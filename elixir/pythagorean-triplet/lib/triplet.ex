defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet), do: Enum.sum(triplet)

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet), do: Enum.reduce(triplet, &(&1*&2))

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]), do: a*a + b*b == c*c

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min \\ 1, max) do
    min..max
    |> Enum.flat_map(&(generate_from_num_range(&1, &1, max)))
    |> Enum.filter(
      fn list -> case list do
        [] -> false
        _ -> true
      end
    end)
  end

  defp generate_from_num_range(a, min, max) do
    min..max
    |> Enum.map(fn b -> [a, b, round(:math.sqrt(a*a + b*b))] end)
    |> Enum.filter(fn triplet -> pythagorean?(triplet) end)
    |> Enum.filter(fn [_, _, c] -> c <= max end)
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum) do
    generate(min, max)
    |> Enum.filter(&(Enum.sum(&1) == sum))
  end
end

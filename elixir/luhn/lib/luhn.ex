defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    case clean_input(number) do
      false -> false
      digits -> valid_number?(digits)
    end
  end

  defp valid_number?(numbers) do
    sum = numbers |> checksum

    cond do
      sum == 0 and length(numbers) == 1 -> false
      rem(sum, 10) == 0 -> true
      true -> false
    end
  end

  defp list_to_integers(numbers), do: Enum.map(numbers, &(String.to_integer(&1)))

  defp checksum(numbers), do: numbers |> doubling |> Enum.sum

  defp clean_input(number) do
    if String.match?(number, ~r{^(\s|\d)*$}) do
      number
      |> String.graphemes
      |> Enum.filter(&(String.match?(&1, ~r{\d})))
      |> list_to_integers
    else
      false
    end
  end

  defp doubling(numbers) do
    if rem(length(numbers), 2) == 0 do
      Enum.map_every(numbers, 2, &(conditional_doubling(&1)))
    else
      tl(Enum.map_every([0 | numbers], 2, &(conditional_doubling(&1))))
    end
  end

  defp conditional_doubling(number) when 2 * number < 10, do: 2 * number
  defp conditional_doubling(number), do: 2 * number - 9
end

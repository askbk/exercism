defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n) when n < 1, do: raise(ArgumentError)
  def nth(1), do: 2

  def nth(count) do
    find_next_prime(nth(count - 1) + 1)
  end

  defp find_next_prime(n) do
    if is_composite(n) do
      find_next_prime(n + 1)
    else
      n
    end
  end

  defp is_composite(n) do
    2..(n - 1)
    |> Enum.any?(&(Integer.mod(n, &1) == 0))
  end
end

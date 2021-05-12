defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    Range.new(2, limit)
    |> Enum.reduce(%{}, fn number, primes ->
      case Map.fetch(primes, number) do
        :error -> mark_multiples_not_prime(Map.put(primes, number, true), number, limit)
        {:ok, false} -> Map.delete(primes, number)
      end
    end)
    |> Enum.map(fn {number, _is_prime} -> number end)
    |> Enum.sort
  end

  def mark_multiples_not_prime(primes, multiple, limit) do
    range_max = div(limit, multiple)

    if range_max >= multiple do
      Range.new(multiple, range_max)
      |> Enum.reduce(primes, fn number, primes_acc ->
        Map.put(primes_acc, number*multiple, false)
      end)
    else
      primes
    end
  end
end

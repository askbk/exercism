defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(1), do: 0
  def calc(n) when n > 0 and is_integer(n), do: collatz(n, 0)

  defp collatz(1, steps), do: steps
  defp collatz(n, steps) when rem(n, 2) == 0, do: collatz(div(n, 2), steps + 1)
  defp collatz(n, steps), do: collatz(3 * n + 1, steps + 1)
end

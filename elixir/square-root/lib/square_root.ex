defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(1), do: 1
  def calculate(radicand), do: do_binary_search(1, radicand, radicand)

  defp do_binary_search(left, right, _) when abs(left - right) < 0.1, do: Float.round(left)

  defp do_binary_search(left, right, radicand) do
    mean = (left + right) / 2
    tentative = mean * mean

    cond do
      tentative < radicand -> do_binary_search(mean, right, radicand)
      tentative >= radicand -> do_binary_search(left, mean, radicand)
    end
  end
end

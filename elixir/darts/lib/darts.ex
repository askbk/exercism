defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score({x, y}) when x * x + y * y <= 1, do: 10
  def score({x, y}) when x * x + y * y <= 25, do: 5
  def score({x, y}) when x * x + y * y <= 100, do: 1
  def score({_, _}), do: 0
end

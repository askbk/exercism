defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct [:white, :black]

  @doc """
  Creates a new set of Queens
  """
  @spec new(Keyword.t()) :: Queens.t()
  def new(opts \\ []) do
    black = Keyword.get(opts, :black, {:unused, :unused})
    white = Keyword.get(opts, :white, {:unused, :unused})

    if valid_positions?(black, white) do
      %Queens{white: white, black: black}
    else
      raise ArgumentError
    end
  end

  defp valid_positions?({x1, y1}, {x2, y2}) when x1 == x2 and y1 == y2, do: false
  defp valid_positions?({x1, y1}, {x2, y2}), do: valid_numbers?([x1, x2, y1, y2])

  defp valid_numbers?([]), do: true
  defp valid_numbers?([n | tail]), do: valid_number?(n) and valid_numbers?(tail)

  defp valid_number?(n) when 0 <= n and n < 8, do: true
  defp valid_number?(:unused), do: true
  defp valid_number?(_), do: false

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    "_ "
    |> String.duplicate(8)
    |> String.replace_trailing(" ", "\n")
    |> String.duplicate(8)
    |> String.trim_trailing
    |> place_queen(queens.black, "B")
    |> place_queen(queens.white, "W")
  end

  defp place_queen(board_string, {:unused, :unused}, _), do: board_string
  defp place_queen(board_string, {x, y}, symbol) do
    string_replace_at(board_string, 16*x + 2*y, symbol)
  end

  defp string_replace_at(string, position, replacement) do
    a = String.slice(string, 0..position-1)
    b = String.slice(string, (position+1)..301)

    cond do
      position - 1 < 0 -> replacement <> b
      position + 1 > 16*8 + 2*8 -> a <> replacement
        true -> a <> replacement <> b
    end
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    straight_attack?(queens.black, queens.white) or diagonal_attack?(queens.black, queens.white)
  end

  defp straight_attack?({x1, _}, {x2, _}) when x1 == x2, do: true
  defp straight_attack?({_, y1}, {_, y2}) when y1 == y2, do: true
  defp straight_attack?(_, _), do: false

  defp diagonal_attack?({x1, y1}, {x2, y2}) when y1 - x1 == y2 - x2, do: true
  defp diagonal_attack?({x1, y1}, {x2, y2}) when y1 + x1 == y2 + x2, do: true
  defp diagonal_attack?(_, _), do: false
end

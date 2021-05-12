defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn row ->
      row
      |> String.split
      |> Enum.map(&(String.to_integer(&1)))
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows
    |> Enum.zip
    |> Enum.map(&(Tuple.to_list(&1)))
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    rows = rows(str)
    cols = columns(str)
    col_mins = Enum.map(cols, &(Enum.min(&1)))

    rows
    |> Enum.with_index
    |> find_saddle_points(col_mins)
    |> IO.inspect
    |> Enum.flat_map(&(&1))
  end

  defp find_saddle_points([], _), do: []
  defp find_saddle_points([{row, row_index} | tail], col_mins) do
    row_max = Enum.max(row)

    [
      row
      |> Enum.with_index
      |> Enum.zip(col_mins)
      |> row_saddle_points([], row_index, row_max)
      | find_saddle_points(tail, col_mins)
    ]
  end

  defp row_saddle_points([], _, _, _), do: []
  defp row_saddle_points([{{row_element, _}, col_min} | tail], acc, row_index, row_max) when row_element < row_max or row_element > col_min do
    row_saddle_points(tail, acc, row_index, row_max)
  end
  defp row_saddle_points([{{row_element, col_index}, col_min} | tail], acc, row_index, row_max) when row_element >= row_max and row_element <= col_min do
    [{row_index, col_index} | row_saddle_points(tail, acc, row_index, row_max)]
  end
end

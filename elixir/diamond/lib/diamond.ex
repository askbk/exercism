defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    width = 2 * (letter - ?A + 1) - 1

    build_shape_row(?A, letter, width)
  end

  defp build_shape_row(?A, last_letter, width) do
    padding = div((width - 1), 2)
    row = String.duplicate(" ", padding) <> "A" <> String.duplicate(" ", padding) <> "\n"

    if last_letter == ?A do
      row
    else
      row <> build_shape_row(?A + 1, last_letter, width) <> row
    end
  end

  defp build_shape_row(letter, last_letter, width) do
    middle = 2*(letter - ?A) - 1
    sides = max(div(width - middle - 2, 2), 0)

    row = String.duplicate(" ", sides) <> ascii_to_string(letter) <> String.duplicate(" ", middle) <> ascii_to_string(letter) <> String.duplicate(" ", sides) <> "\n"

    if sides == 0 do
      row
    else
      row <> build_shape_row(letter + 1, last_letter, width) <> row
    end
  end

  defp ascii_to_string(ascii), do: List.to_string([ascii])
end

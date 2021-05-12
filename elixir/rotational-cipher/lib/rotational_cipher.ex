import String

defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text 
    |> graphemes 
    |> Enum.map(fn letter -> 
      cond do
        is_alphabetic?(letter) -> letter |> rotate_letter(shift) |> List.to_string
        true -> letter
      end
    end)
    |> Enum.join
  end

  defp is_alphabetic?(char), do: Regex.match?(~r/^[A-Za-z]$/, char)

  defp is_upcase?(text), do: upcase(text) == text

  defp rotate_letter(letter, shift) do
    cond do
      is_upcase?(letter) -> letter |> Kernel.to_charlist |> rotate_uppercase(shift)
      true -> letter |> Kernel.to_charlist |> rotate_lowercase(shift)
    end
  end

  defp rotate_uppercase([letter], shift), do: [rem(letter + shift - 65, 26) + 65]
  defp rotate_lowercase([letter], shift), do: [rem(letter + shift - 97, 26) + 97]
end

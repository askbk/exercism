defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    normalized = normalize(str)
    size = String.length(normalized)
    {c, r} = get_dimensions(size)

    normalized
    |> String.pad_trailing(c*r)
    |> splitter(c)
    |> joiner
  end

  defp normalize(string) do
    string |> String.replace([" ", ",", ".", "?", "!", "-", "'"], "") |> String.downcase
  end

  defp get_dimensions(size), do: do_get_dimensions(1, size, size)

  defp do_get_dimensions(c, r, _) when r <= c and c <= r + 1, do: {c, r}
  defp do_get_dimensions(c, _, size) do
    do_get_dimensions(c + 1, ceil_div(size, c + 1), size)
  end

  defp ceil_div(a, b) do
    if rem(a, b) > 0 do
      div(a, b) + 1
    else
      div(a, b)
    end
  end

  defp splitter("", _), do: []
  defp splitter(string, count) do
    {start, rest} = String.split_at(string, count)
    [String.codepoints(start) | splitter(rest, count)]
  end

  defp joiner(strings) do
    strings
    |> Enum.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.trim/1)
    |> Enum.join(" ")
  end
end

defmodule Username do
  def sanitize(username) do
    username
    |> Enum.flat_map(&get_char_substitute/1)
    |> Enum.filter(&lowercase_letter_or_underscore/1)
  end

  defp lowercase_letter_or_underscore(char) when char in ?a..?z, do: true
  defp lowercase_letter_or_underscore(?_), do: true
  defp lowercase_letter_or_underscore(_), do: false

  defp get_char_substitute(char) do
    case char do
      ?ä -> [?a, ?e]
      ?ö -> [?o, ?e]
      ?ü -> [?u, ?e]
      ?ß -> [?s, ?s]
      _ -> [char]
    end
  end
end

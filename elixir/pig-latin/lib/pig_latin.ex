defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(&(translate_word(&1)))
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    split_index = find_split_index(word)

    {beginning, rest} = String.split_at(word, split_index)
    
    rest <> beginning <> "ay"
  end
  
  defp is_vowel(letter) when is_binary(letter) do
    lower = String.downcase(letter)
    
    lower in ["a", "e", "i", "o", "u"]
  end

  defp find_split_index(word) do
    cond do
      String.starts_with?(word, ["squ", "thr", "sch"]) -> 3
      String.starts_with?(word, ["ch", "qu", "th"]) -> 2
      starts_with_vowel_group(word) -> 0
      true -> word 
              |> String.graphemes 
              |> Enum.find_index(&(is_vowel(&1)))
    end
  end

  def starts_with_vowel_group(word) do
    unless String.at(word, 0) in ["x", "y"] do
      is_vowel(String.at(word, 0))
    else
      !is_vowel(String.at(word, 1))
    end
  end
end

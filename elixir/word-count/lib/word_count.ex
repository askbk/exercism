defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
      |> String.downcase
      |> String.split(~r{[\s_!"#$%&'()*+,\./:;<=>?@^_`|]}, trim: true)
      |> Enum.reduce(%{}, 
        fn word, counts ->
          Map.update(counts, word, 1, fn c -> c + 1 end)
        end
      )
  end
end

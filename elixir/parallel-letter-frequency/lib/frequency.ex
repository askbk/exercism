defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], _), do: %{}
  def frequency(texts, workers) do
    stream = Task.async_stream(texts, &(counter(&1)))

    stream
    |> Enum.reduce(%{},
      fn {:ok, counts}, acc_counts ->
        Map.merge(counts, acc_counts, fn _k, v1, v2 -> v1 + v2 end)
      end)
  end

  @spec counter(String.t()) :: map
  def counter(text) do
    text
    |> String.downcase
    |> String.split("", trim: true)
    |> Enum.filter(fn character ->
      String.length(String.trim(character)) > 0 and
      String.upcase(character) != String.downcase(character)
    end)
    |> Enum.reduce(%{}, fn letter, counts ->
      Map.update(counts, letter, 1, &(&1 + 1))
    end)
  end
end

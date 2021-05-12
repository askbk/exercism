defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(0), do: "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
  def verse(number) do
    "#{number} #{bottle_conjugate(number)} of beer on the wall, #{number} #{bottle_conjugate(number)} of beer.\nTake #{if number == 1, do: "it", else: "one"} down and pass it around, #{if number - 1 == 0, do: "no more", else: number - 1} #{bottle_conjugate(number - 1)} of beer on the wall.\n"
  end

  defp bottle_conjugate(number) do
    cond do
      number == 1 -> "bottle"
      true -> "bottles"
    end
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    Enum.reduce(range, "", fn i, verses -> "#{verses}#{if String.length(verses) > 0, do: "\n"}#{verse(i)}" end)
  end

  def lyrics(), do: lyrics(99..0)
end

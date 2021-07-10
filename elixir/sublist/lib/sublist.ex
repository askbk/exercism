defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare(list_a, list_b) when length(list_a) == length(list_b),
    do: equal_or_unequal(list_a, list_b)

  def compare(list_a, list_b) when length(list_a) < length(list_b),
    do: sublist_or_unequal(list_a, list_b)

  def compare(list_a, list_b) when length(list_a) > length(list_b),
    do: superlist_or_unequal(list_a, list_b)

  defp equal_or_unequal(list_a, list_b) when list_a == list_b, do: :equal
  defp equal_or_unequal(_, _), do: :unequal

  defp sublist_or_unequal(_, []), do: :unequal

  defp sublist_or_unequal(list_a, list_b) do
    if List.starts_with?(list_b, list_a) do
      :sublist
    else
      sublist_or_unequal(list_a, tl(list_b))
    end
  end

  defp superlist_or_unequal([], _), do: :unequal

  defp superlist_or_unequal(list_a, list_b) do
    if List.starts_with?(list_a, list_b) do
      :superlist
    else
      superlist_or_unequal(tl(list_a), list_b)
    end
  end
end

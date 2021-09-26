defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """
  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key), do: bisect(numbers, key, 0, tuple_size(numbers) - 1)
  defp bisect(_numbers, _key, left, right) when right < left, do: :not_found

  defp bisect(numbers, key, left, right) do
    middle_index = div(left + right, 2)
    middle = elem(numbers, middle_index)

    cond do
      middle == key ->
        {:ok, middle_index}

      key < middle ->
        bisect(numbers, key, left, middle_index - 1)

      middle < key ->
        bisect(numbers, key, middle_index + 1, right)
    end
  end
end

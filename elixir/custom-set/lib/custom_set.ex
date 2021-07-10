defmodule CustomSet do
  @opaque t :: %__MODULE__{items: map()}
  defstruct items: MapSet.new()

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    %CustomSet{items: MapSet.new(enumerable)}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    MapSet.size(custom_set.items) == 0
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    MapSet.member?(custom_set.items, element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    MapSet.subset?(custom_set_1.items, custom_set_2.items)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    MapSet.disjoint?(custom_set_1.items, custom_set_2.items)
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    MapSet.equal?(custom_set_1.items, custom_set_2.items)
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    %CustomSet{items: MapSet.put(custom_set.items, element)}
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    %CustomSet{items: MapSet.intersection(custom_set_1.items, custom_set_2.items)}
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    %CustomSet{items: MapSet.difference(custom_set_1.items, custom_set_2.items)}
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    %CustomSet{items: MapSet.union(custom_set_1.items, custom_set_2.items)}
  end
end

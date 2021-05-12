defmodule Zipper do

  @type t :: %Zipper{focus: BinTree.t(), parent: Zipper.t()}
  defstruct [:focus, :parent]

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(nil), do: nil
  def from_tree(nil, _), do: nil
  def from_tree(bin_tree, parent \\ nil) do
    %Zipper{focus: bin_tree, parent: parent}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(nil), do: nil
  def to_tree(zipper) do
    root_zipper = find_root(zipper)
    root_zipper.focus
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(zipper) do
    zipper.focus.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(zipper) do
    from_tree(zipper.focus.left, zipper)
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(zipper) do
    from_tree(zipper.focus.right, zipper)
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(zipper) do
    zipper.parent
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
  end

  defp find_root(zipper) do
    if is_nil(up(zipper)) do
      zipper
    else
      find_root(up(zipper))
    end
  end
end

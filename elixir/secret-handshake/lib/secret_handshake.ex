defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(0), do: []
  def commands(1), do: ["wink"]
  def commands(2), do: ["double blink"]
  def commands(4), do: ["close your eyes"]
  def commands(8), do: ["jump"]
  def commands(code) do
    cond do
      code >= 16 -> commands(code - 16) |> Enum.reverse
      code >= 8 -> commands(code - 8) ++ commands(8)
      code >= 4 -> commands(code - 4) ++ commands(4)
      code >= 2 -> commands(code - 2) ++ commands(2)
    end
  end
end

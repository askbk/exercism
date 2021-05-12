import String

defmodule Bob do
  def hey(input) do
    trimmed = trim(input)
    
    cond do
      is_yelling?(trimmed) and is_question?(trimmed) -> "Calm down, I know what I'm doing!"
      is_yelling?(trimmed) -> "Whoa, chill out!"
      is_question?(trimmed) -> "Sure."
      is_quiet?(trimmed) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end

  def is_question?(input), do: at(input, -1) == "?"

  def is_yelling?(input), do:  upcase(input) == input and upcase(input) != downcase(input)

  def is_quiet?(input), do: (input |> String.length) == 0
end

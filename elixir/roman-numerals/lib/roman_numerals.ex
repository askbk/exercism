defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) when number >= 0 do
    digits = get_digits(number)

    digits 
      |> Enum.reduce({"", length(digits)}, 
        fn digit, acc -> 
          magnitude = elem(acc, 1) - 1
          temp = elem(acc, 0)
          component = digit * round(:math.pow(10, magnitude))

          {temp <> component_to_numeral(component), magnitude}
        end
      )
      |> elem(0)
  end

  def component_to_numeral(0), do: ""

  def component_to_numeral(component) do
    nums = [{1, "I"}, {5, "V"}, {10, "X"}, {50, "L"}, {100, "C"}, {500, "D"}, {1000, "M"}, {5000, "Y"}]

    {next_value, next_symbol} = nums |> Enum.find(fn {v, _s} -> v >= component end)

    if next_value == component do
      next_symbol
    else
      sub_stuff = nums |> Enum.find(fn {v, _s} -> next_value - v == component end)
      {prev_value, prev_symbol} = nums |> Enum.find(fn {v, _s} -> v >= next_value / 5 end)
      
      if sub_stuff  do
        elem(sub_stuff, 1) <> next_symbol
      else
        repetitions = div(component, prev_value)

        String.duplicate(prev_symbol, repetitions) <> component_to_numeral(component - repetitions * prev_value)
      end
    end
  end
  
  def get_digits(number) do
    number
      |> to_string
      |> String.split("", trim: true)
      |> Enum.map(&(String.to_integer(&1)))
  end
end

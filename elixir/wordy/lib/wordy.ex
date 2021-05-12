defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    question
    |> parse
    |> evaluate
  end

  defp evaluate([number]), do: number
  defp evaluate(expression) do
    [operand1 | [operator | [operand2 | rest]]] = expression

    evaluate([calculate(operator, operand1, operand2) | rest])
  end

  defp calculate("plus", operand1, operand2), do: operand1 + operand2
  defp calculate("minus", operand1, operand2), do: operand1 - operand2
  defp calculate("multiplied", operand1, operand2), do: operand1 * operand2
  defp calculate("divided", operand1, operand2), do: div(operand1, operand2)

  defp parse(string) do
    string
    |> String.slice(8..-2)
    |> String.split
    |> Enum.filter(fn element ->
      cond do
        string_is_integer(element) -> true
        is_operator(element) -> true
        is_unknown_operator(element) -> raise ArgumentError
        true -> false
      end
    end)
    |> Enum.map(fn element ->
      case Integer.parse(element) do
        {integer, _} -> integer
          :error -> element
      end
    end)
  end

  defp string_is_integer(string) do
    case Integer.parse(string) do
      {number, _} -> true
        _ -> false
    end
  end

  defp is_operator("plus"), do: true
  defp is_operator("minus"), do: true
  defp is_operator("multiplied"), do: true
  defp is_operator("divided"), do: true
  defp is_operator(_), do: false

  defp is_unknown_operator("by"), do: false
  defp is_unknown_operator(operator), do: !is_operator(operator)
end

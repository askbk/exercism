defmodule LanguageList do
  def new(), do: []

  def add(list, language), do: [language | list]

  def remove([_ | t]), do: t

  def first([h | _]), do: h

  def count([]), do: 0
  def count([_ | t]), do: 1 + count(t)

  def exciting_list?([]), do: false
  def exciting_list?(["Elixir" | _]), do: true
  def exciting_list?([_ | t]), do: exciting_list?(t)
end

defmodule Lasagna do
  def expected_minutes_in_oven(), do: 40
  def remaining_minutes_in_oven(minutes), do: expected_minutes_in_oven() - minutes
  def preparation_time_in_minutes(layer_count), do: layer_count * 2

  def total_time_in_minutes(layer_count, minutes_in_oven),
    do: preparation_time_in_minutes(layer_count) + minutes_in_oven

  def alarm(), do: "Ding!"
end

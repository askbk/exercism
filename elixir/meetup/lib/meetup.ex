defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    res = meetup1(year, month, weekday, schedule)

    res
  end

  def meetup1(year, month, weekday, schedule) do
    first = find_first_weekday(year, month, weekday)
    case schedule do
      :first -> add_weeks(year, month, first, 0)
      :second -> add_weeks(year, month, first, 1)
      :third -> add_weeks(year, month, first, 2)
      :fourth -> add_weeks(year, month, first, 3)
      :last -> find_last_weekday(year, month, weekday)
      :teenth -> find_teenth_weekday(year, month, first)
    end
  end

  defp add_weeks(year, month, first, weeks) do
    {_, date} = Date.new(year, month, first)

    Date.add(date, weeks * 7)
  end

  defp find_last_weekday(year, month, weekday) do
    days_in_month = Date.days_in_month(elem(Date.new(year, month, 1), 1))
    {_, last_day_in_month} = Date.new(year, month, days_in_month)

    day_of_week = Date.day_of_week(last_day_in_month)

    Date.add(last_day_in_month, -(day_of_week - weekday_atom_to_num(weekday)))
  end

  defp find_teenth_weekday(year, month, first) do
    {_, date} = Date.new(year, month, first)

    if first + 7 > 12 do
      Date.add(date, 7)
    else
      Date.add(date, 14)
    end
  end

  defp find_first_weekday(year, month, weekday) do
    {_, date} = Date.new(year, month, 1)

    day_of_week = Date.day_of_week(date)

    1 + weekday_distance(day_of_week, weekday_atom_to_num(weekday))
  end

  defp weekday_distance(a, b) do
    if a <= b do
      b - a
    else
      b - a + 7
    end
  end

  defp weekday_atom_to_num(weekday) do
    case weekday do
      :monday -> 1
      :tuesday -> 2
      :wednesday -> 3
      :thursday -> 4
      :friday -> 5
      :saturday -> 6
      :sunday -> 7
    end
  end
end

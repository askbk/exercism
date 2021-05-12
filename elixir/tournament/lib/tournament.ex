import String

defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(&(parse_result(&1)))
    |> Enum.reduce(%{}, &(add_result(&1, &2)))
    |> Enum.map(fn {team, res} -> Map.put(res, :name, team) end)
    |> format_results
  end

  defp parse_result(line), do: String.split(line, ";")

  defp add_result([team1, team2, outcome], results) do
    case outcome do
      "win" -> results |> add_win(team1) |> add_loss(team2)
      "loss" -> results |> add_loss(team1) |> add_win(team2)
      "draw" -> results |> add_draw(team1) |> add_draw(team2)
      _ -> results
    end
  end
  defp add_result(_, results), do: results

  defp format_results(results) do
    "Team                           | MP |  W |  D |  L |  P\n" <>
    (results
    |> Enum.sort(fn team1_res, team2_res -> team1_res.p > team2_res.p or (team1_res.p == team2_res.p and team1_res.name <= team2_res.name) end)
    |> Enum.map(fn result -> format_result(result) end)
    |> Enum.join("\n"))
  end

  defp format_result(result) do
    pad_trailing(result.name, 30) <> format_number(result.mp) <> format_number(result.w) <> format_number(result.d) <> format_number(result.l) <> format_number(result.p)
  end

  defp format_number(number), do: " | " <> pad_leading(to_string(number), 2)

  defp add_win(results, team) do
    update_results(results, team, &(%{&1 | w: &1.w + 1, mp: &1.mp + 1, p: &1.p + 3}))
  end

  defp add_loss(results, team) do
    update_results(results, team, &(%{&1 | l: &1.l + 1, mp: &1.mp + 1}))
  end

  defp add_draw(results, team) do
    update_results(results, team, &(%{&1 | d: &1.d + 1, mp: &1.mp + 1, p: &1.p + 1}))
  end

  defp update_results(results, team, fun) do
    Map.put_new(results, team, %{w: 0, d: 0, l: 0, mp: 0, p: 0})
    |> Map.update!(team, fun)
  end
end

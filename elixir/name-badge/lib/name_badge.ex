defmodule NameBadge do
  def print(id, name, department) do
    get_id_string(id) <> name <> " - " <> get_dep_string(department)
  end

  defp get_id_string(nil), do: ""
  defp get_id_string(id), do: "[#{id}] - "

  defp get_dep_string(nil), do: "OWNER"
  defp get_dep_string(department), do: String.upcase(department)
end

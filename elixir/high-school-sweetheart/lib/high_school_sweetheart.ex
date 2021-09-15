defmodule HighSchoolSweetheart do
  def first_letter(name), do: name |> String.trim() |> String.first()

  def initial(name), do: name |> first_letter() |> String.upcase() |> (&"#{&1}.").()

  def initials(full_name),
    do: full_name |> String.split() |> Enum.map(&initial/1) |> Enum.join(" ")

  def pair(full_name1, full_name2) do
    first_initials = initials(full_name1)
    second_initials = initials(full_name2)
    "     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     #{first_initials}  +  #{second_initials}     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *\n"
  end
end

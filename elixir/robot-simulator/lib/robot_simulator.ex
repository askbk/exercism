defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    cond do
      not is_valid_position?(position) -> {:error, "invalid position"}
      not is_valid_direction?(direction) -> {:error, "invalid direction"}
      true -> %{direction: direction, position: position}
    end
  end

  defp is_valid_position?(position) do
    case position do
      {x, y} -> is_integer(x) and is_integer(y)
      _ -> false
    end
  end

  defp is_valid_direction?(direction) do
    case direction do
      :north -> true
      :west -> true
      :south -> true
      :east -> true
      _ -> false
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
      |> String.split("", trim: true) 
      |> Enum.reduce(robot, fn instruction, robot ->
        case robot do
          {:error, msg} -> {:error, msg}
          robot -> move(robot, instruction)
        end
      end)
  end

  defp move(robot, instruction) do
    case instruction do
      "A" -> advance(robot)
      "L" -> turn(robot, instruction)
      "R" -> turn(robot, instruction)
      _ -> {:error, "invalid instruction"}
    end
  end

  defp advance(robot) do
    facing = direction(robot)
    {x, y} = position(robot)
    
    case facing do
      :west -> create(facing, {x - 1, y})
      :east -> create(facing, {x + 1, y})
      :north -> create(facing, {x, y + 1})
      :south -> create(facing, {x, y - 1})
      _ -> {:error, "invalid direction"}
    end
  end
  
  defp turn(robot, hand) do
    facing = direction(robot)
    position = position(robot)
    
    case hand do
      "L" -> create(counter_clockwise(facing), position)
      "R" -> create(clockwise(facing), position)
    end
  end

  defp counter_clockwise(direction) do
    case direction do 
      :north -> :west
      :west -> :south
      :south -> :east
      :east -> :north
      _ -> {:error, "invalid direction"}
    end
  end

  defp clockwise(direction) do
    case direction do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
      _ -> {:error, "invalid direction"}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot[:direction]
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot[:position]
  end
end

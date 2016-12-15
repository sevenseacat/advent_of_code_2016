defmodule Advent.Day13Test do
  use ExUnit.Case
  alias Advent.Day13
  alias Advent.Day13.Position

  doctest Advent.Day13
  doctest Advent.Day13.Position

  test "running an actual scenario for a given initial position and returning a path length" do
    path = Position.initial |> Day13.get_optimal_path([7, 4], 10)
    assert path == [[1, 2], [2, 2], [3, 2], [3, 3], [3, 4], [4, 4],
      [4, 5], [5, 5], [6, 5], [6, 4], [7, 4]]
  end
end

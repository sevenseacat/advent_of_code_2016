defmodule Advent.Day11.Elevator do
  alias Advent.Day11.State

  @doc """
  iex> Advent.Day11.Elevator.valid_moves(%Advent.Day11.State{elevator: 1, floors: [
  ...>  %Advent.Day11.Floor{number: 1}, %Advent.Day11.Floor{number: 2}]})
  [2]

  iex> Advent.Day11.Elevator.valid_moves(%Advent.Day11.State{elevator: 2, floors: [
  ...>  %Advent.Day11.Floor{number: 1}, %Advent.Day11.Floor{number: 2}]})
  [1]

  iex> Advent.Day11.Elevator.valid_moves(%Advent.Day11.State{elevator: 2, floors: [
  ...>  %Advent.Day11.Floor{number: 1}, %Advent.Day11.Floor{number: 2},
  ...>  %Advent.Day11.Floor{number: 3}]})
  [1, 3]
  """
  def valid_moves(%State{floors: floors, elevator: elevator}) do
    [elevator+1, elevator-1]
    |> Enum.filter(fn(floor) -> Enum.any?(floors, &(&1.number == floor)) end)
  end
end

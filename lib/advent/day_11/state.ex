defmodule Advent.Day11.State do
  alias Advent.Day11.{State, Floor}
  defstruct floors: [], elevator: 1

  @winning_floor 4

  def winning_floor, do: @winning_floor

  def initial do
    Code.eval_file("test/fixtures/day_11") |> elem(0)
  end

  @doc """
  iex> Advent.Day11.State.legal?(%Advent.Day11.State{floors: [
  ...>  %Advent.Day11.Floor{number: 1, chips: [:s], generators: [:s]}
  ...> ]})
  true

  iex> Advent.Day11.State.legal?(%Advent.Day11.State{floors: [
  ...>  %Advent.Day11.Floor{number: 1, chips: [:s, :r], generators: [:s]}
  ...> ]})
  false # R chip is fried by S generator

  iex> Advent.Day11.State.legal?(%Advent.Day11.State{floors: [
  ...>  %Advent.Day11.Floor{number: 1, chips: [:s], generators: [:s, :r]}
  ...> ]})
  true
  """
  def legal?(%State{floors: floors}) do
    Enum.all?(floors, &Floor.legal?/1)
  end

  @doc """
  iex> Advent.Day11.State.winning?(%Advent.Day11.State{elevator: 1, floors: [
  ...>  %Advent.Day11.Floor{number: 4, chips: [:s], generators: [:s, :r]}
  ...> ]})
  false

  iex> Advent.Day11.State.winning?(%Advent.Day11.State{elevator: 4, floors: [
  ...>  %Advent.Day11.Floor{number: 4, chips: [:r, :s], generators: [:s, :r]},
  ...>  %Advent.Day11.Floor{number: 3, chips: [], generators: []}
  ...> ]})
  true

  iex> Advent.Day11.State.winning?(%Advent.Day11.State{elevator: 1, floors: [
  ...>  %Advent.Day11.Floor{number: 4, chips: [:r, :c], generators: [:s, :r]},
  ...>  %Advent.Day11.Floor{number: 3, chips: [], generators: []}
  ...> ]})
  false
  """
  def winning?(%State{elevator: elevator}) when elevator != @winning_floor, do: false
  def winning?(%State{floors: floors}) do
    Enum.all?(floors, &Floor.winning?/1)
  end
end

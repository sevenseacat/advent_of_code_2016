defmodule Advent.Day11Test do
  use ExUnit.Case

  alias Advent.Day11
  alias Advent.Day11.{State, Floor}

  doctest Advent.Day11
  doctest Advent.Day11.State
  doctest Advent.Day11.Floor

  test "calculating legal moves for a given state" do
    expected_states = [
      %State{elevator: 1, floors: [
        %Floor{number: 1, chips: [:s], generators: []},
        %Floor{number: 2, chips: [:r], generators: [:r, :s]},
        %Floor{number: 3, chips: [], generators: []}]},
      %State{elevator: 1, floors: [
        %Floor{number: 1, chips: [:r], generators: []},
        %Floor{number: 2, chips: [:s], generators: [:r, :s]},
        %Floor{number: 3, chips: [], generators: []}]},
      %State{elevator: 1, floors: [
        %Floor{number: 1, chips: [:s], generators: [:s]},
        %Floor{number: 2, chips: [:r], generators: [:r]},
        %Floor{number: 3, chips: [], generators: []}]},
      %State{elevator: 1, floors: [
        %Floor{number: 1, chips: [:r], generators: [:r]},
        %Floor{number: 2, chips: [:s], generators: [:s]},
        %Floor{number: 3, chips: [], generators: []}]},
      %State{elevator: 1, floors: [
        %Floor{number: 1, chips: [:r, :s], generators: []},
        %Floor{number: 2, chips: [], generators: [:r, :s]},
        %Floor{number: 3, chips: [], generators: []}]},
      %State{elevator: 1, floors: [
        %Floor{number: 1, chips: [], generators: [:r, :s]},
        %Floor{number: 2, chips: [:r, :s], generators: []},
        %Floor{number: 3, chips: [], generators: []}]},
      %State{elevator: 3, floors: [
        %Floor{number: 1, chips: [], generators: []},
        %Floor{number: 2, chips: [:r], generators: [:r, :s]},
        %Floor{number: 3, chips: [:s], generators: []}]},
      %State{elevator: 3, floors: [
        %Floor{number: 1, chips: [], generators: []},
        %Floor{number: 2, chips: [:s], generators: [:r, :s]},
        %Floor{number: 3, chips: [:r], generators: []}]},
      %State{elevator: 3, floors: [
        %Floor{number: 1, chips: [], generators: []},
        %Floor{number: 2, chips: [:r], generators: [:r]},
        %Floor{number: 3, chips: [:s], generators: [:s]}]},
      %State{elevator: 3, floors: [
        %Floor{number: 1, chips: [], generators: []},
        %Floor{number: 2, chips: [:s], generators: [:s]},
        %Floor{number: 3, chips: [:r], generators: [:r]}]},
      %State{elevator: 3, floors: [
        %Floor{number: 1, chips: [], generators: []},
        %Floor{number: 2, chips: [], generators: [:r, :s]},
        %Floor{number: 3, chips: [:r, :s], generators: []}]},
      %State{elevator: 3, floors: [
        %Floor{number: 1, chips: [], generators: []},
        %Floor{number: 2, chips: [:r, :s], generators: []},
        %Floor{number: 3, chips: [], generators: [:r, :s]}]}
    ]

    actual_states = State.legal_moves(%State{elevator: 2, floors: [
      %Floor{number: 1, chips: [], generators: []},
      %Floor{number: 2, chips: [:r, :s], generators: [:r, :s]},
      %Floor{number: 3, chips: [], generators: []}]})

    assert length(actual_states) == length(expected_states)
    Enum.each(actual_states, fn(state) ->
      assert state in expected_states
    end)
  end

  test "running an actual scenario for a given initial state and returning a path length" do
    # This is from the example in the puzzle itself.
    initial_state = %State{elevator: 1, floors: [
      %Floor{number: 1, chips: [:h, :l], generators: []},
      %Floor{number: 2, chips: [], generators: [:h]},
      %Floor{number: 3, chips: [], generators: [:l]},
      %Floor{number: 4, chips: [], generators: []}
    ]}

    actual_path = Day11.get_optimal_path(initial_state)
    assert length(actual_path) == 11
  end
end

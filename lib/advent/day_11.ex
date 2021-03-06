defmodule Advent.Day11 do
  alias Advent.Day11.State

  def part1 do
    State.initial
    |> get_optimal_path
    |> length
  end

  def part2 do
    State.part2_initial
    |> get_optimal_path
    |> length
  end

  @doc """
  This is the actual breadth-first search part. ie. the point of the puzzle.
  """
  def get_optimal_path(state) do
    do_search([{[], State.legal_moves(state)}], [], %{})
  end

  # Reached the end of a level. Start going through allll the states on the next level.
  defp do_search([], next_level_states, all_seen_states) do
    IO.puts "* Level #{next_level_states |> hd |> elem(0) |> length}: #{length(next_level_states)} states to check."
    do_search(next_level_states, [], all_seen_states)
  end

  # We've exhausted one state's possible next states - move onto the next state to expand.
  defp do_search([{_path, []} | alt_paths], next_level_states, all_seen_states) do
    do_search(alt_paths, next_level_states, all_seen_states)
  end

  # The main function head - checking all legal moves associated with a given state.
  # If the state doesn't win, expand out it's legal moves, shove them on a stack, and keep looking.
  defp do_search([{path, [state | states]} | alt_paths], next_level_states, all_seen_states) do
    case State.winning?(state) do
      # Jackpot!
      true -> Enum.reverse([state | path])
      false ->
        # Avoid cycles by only using this computed state if it is not already in the path taken to get to this state.
        # Also drastically cut down on the number of states in memory, by recording *all* states
        # we've seen - if we see a state twice, the earlier one was clearly more optimal so disregard future references to it.
        case Map.get(all_seen_states, state, false) do
          true -> do_search([{path, states} | alt_paths], next_level_states, all_seen_states)
          false ->
            all_seen_states = Map.put(all_seen_states, state, true)
            do_search(
              [{path, states} | alt_paths],
              [{[state | path], State.legal_moves(state)} | next_level_states],
              all_seen_states
            )
        end
    end
  end
end

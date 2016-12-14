defmodule Advent.Day11 do
  alias Advent.Day11.State

  @doc """
  See the test file for tests - too long to use doctests for.
  """
  def legal_moves({positions, _elevator}=state) do
    # One or two chips/generators can be moved from one floor to the previous/next
    Enum.map(possible_elevator_positions(state), fn(new_elevator) ->
      Enum.map(possible_item_combinations(state), fn(items_to_move) ->
        {[{new_elevator, {[], []}}], new_elevator}
      end)
    end)
    |> List.flatten
    |> Enum.filter(&State.legal?/1)
  end

  @doc """
  iex> Advent.Day11.possible_elevator_positions({[f1: [], f2: []], :f1})
  [:f2]

  iex> Advent.Day11.possible_elevator_positions({[f1: [], f2: []], :f2})
  [:f1]

  iex> Advent.Day11.possible_elevator_positions({[f1: [], f2: [], f3: []], :f2})
  [:f1, :f3]
  """
  def possible_elevator_positions({positions, current_floor}) do
    number = Atom.to_string(current_floor) |> String.last |> String.to_integer
    ["f#{number-1}", "f#{number+1}"]
    |> Enum.map(&String.to_atom/1)
    |> Enum.filter(fn(floor) -> positions[floor] end)
  end

  @doc """
  iex> Advent.Day11.possible_item_combinations({[f1: {[:r], [:s]}, f2: {[:t, :u], [:v, :w]}], :f2}) |> Enum.sort
  [[:t], [:t, :u], [:t, :v], [:t, :w], [:u], [:u, :v], [:u, :w], [:v], [:v, :w], [:w]]
  """
  def possible_item_combinations({positions, current_floor}) do
    {chips, generators} = positions[current_floor]
    (Enum.map(chips, &({:chip, &1})) ++ Enum.map(generators, &({:generator, &1})))
    |> permutations_of_size(2)
    |> Enum.map(&Enum.sort/1)
    |> Enum.map(fn(list) -> Enum.group_by(list, fn({type, value}) -> value end) end)
    |> Enum.uniq
  end

  defp permutations_of_size(_, 0), do: []
  defp permutations_of_size(floor_data, size) do
    Permutations.of(floor_data, size) ++ permutations_of_size(floor_data, size-1)
  end
end

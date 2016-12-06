defmodule Advent.Day2 do
  @starting_position "5"

  @doc """
  iex> Advent.Day2.bathroom_code(["ULL", "RRDDD", "LURDL", "UUUUD"])
  "1985"
  """
  def bathroom_code(input) do
    calculate_bathroom_code(input, square_keypad)
  end

  @doc """
  iex> Advent.Day2.second_bathroom_code(["ULL", "RRDDD", "LURDL", "UUUUD"])
  "5DB3"
  """
  def second_bathroom_code(input) do
    calculate_bathroom_code(input, diamond_keypad)
  end

  def input do
    File.read!("test/fixtures/day_2") |> String.split
  end

  defp calculate_bathroom_code(input, keypad) do
    input
    |> Enum.scan(@starting_position, fn(move, position) ->
        move
        |> String.to_charlist
        |> calculate_digit(position, keypad)
      end)
    |> List.to_string
  end

  defp calculate_digit([], position, _keypad), do: position
  defp calculate_digit([head|tail], position, keypad) do
    calculate_digit(tail, move(head, position, keypad), keypad)
  end

  defp move(direction, old_position, keypad) do
    new_position = old_position
    |> to_grid_pos(keypad)
    |> make_move(direction)
    |> from_grid_pos(keypad)

    case new_position do
      nil -> old_position
      _   -> new_position
    end
  end

  def square_keypad do
    [
      [nil, nil, nil, nil, nil],
      [nil, "1", "2", "3", nil],
      [nil, "4", "5", "6", nil],
      [nil, "7", "8", "9", nil],
      [nil, nil, nil, nil, nil]
    ]
  end

  def diamond_keypad do
    [
      [nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, "1", nil, nil, nil],
      [nil, nil, "2", "3", "4", nil, nil],
      [nil, "5", "6", "7", "8", "9", nil],
      [nil, nil, "A", "B", "C", nil, nil],
      [nil, nil, nil, "D", nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil]
    ]
  end

  @doc """
  Convert a character to its position on the bathroom keypad.

  iex> Advent.Day2.to_grid_pos("6", Advent.Day2.square_keypad)
  {3, 2}

  iex> Advent.Day2.to_grid_pos("1", Advent.Day2.square_keypad)
  {1, 1}

  iex> Advent.Day2.to_grid_pos("6", Advent.Day2.diamond_keypad)
  {2, 3}

  iex> Advent.Day2.to_grid_pos("B", Advent.Day2.diamond_keypad)
  {3, 4}
  """
  def to_grid_pos(position, keypad) do
    columns = keypad
    |> Enum.map(fn(row) ->
        Enum.find_index(row, &(&1 == position))
      end)

    {Enum.find(columns, &(&1 != nil)), Enum.find_index(columns, &(&1 != nil))}
  end

  @doc """
  Convert a position on a bathroom keypad to a character.

  iex> Advent.Day2.from_grid_pos({1, 1}, Advent.Day2.square_keypad)
  "1"

  iex> Advent.Day2.from_grid_pos({3, 2}, Advent.Day2.square_keypad)
  "6"

  iex> Advent.Day2.from_grid_pos({4, 4}, Advent.Day2.diamond_keypad)
  "C"
  """
  def from_grid_pos({x, y}, keypad) do
    keypad
    |> Enum.at(y)
    |> Enum.at(x)
  end

  def make_move({x, y}, ?L), do: {x-1, y}
  def make_move({x, y}, ?R), do: {x+1, y}
  def make_move({x, y}, ?U), do: {x, y-1}
  def make_move({x, y}, ?D), do: {x, y+1}
end

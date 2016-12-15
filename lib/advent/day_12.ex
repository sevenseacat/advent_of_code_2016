defmodule Advent.Day12 do
  # Advent.Day12.input |> Advent.Day12.run_assembunny_code

  @doc """
  iex> Advent.Day12.run_assembunny_code(["cpy 41 a", "inc a", "inc a", "dec a",
  ...>  "jnz a 2", "dec a"]) |> elem(0)
  42
  """
  def run_assembunny_code(input) do
    execute_instructions(input, input, {0,0,0,0}, 0)
  end

  def run_new_assembunny_code(input) do
    execute_instructions(input, input, {0,0,1,0}, 0)
  end

  def execute_instructions([], _input, state, _index), do: state
  def execute_instructions([line|_lines], input, state, index) do
    {state, index} = line
    |> String.split(" ")
    |> execute_instruction(state, index)

    {_run, lines} = Enum.split(input, index)
    execute_instructions(lines, input, state, index)
  end

  @doc """
  iex> Advent.Day12.execute_instruction(["inc", "b"], {2, 3, 4, 5}, 1)
  {{2, 4, 4, 5}, 2}
  """
  def execute_instruction(["inc", letter], state, index) do
    new_state = put_elem(state, register(letter), elem(state, register(letter))+1)
    {new_state, index+1}
  end

  @doc """
  iex> Advent.Day12.execute_instruction(["dec", "c"], {2, 3, 4, 5}, 4)
  {{2, 3, 3, 5}, 5}
  """
  def execute_instruction(["dec", letter], state, index) do
    new_state = put_elem(state, register(letter), elem(state, register(letter))-1)
    {new_state, index+1}
  end

  @doc """
  iex> Advent.Day12.execute_instruction(["cpy", "47", "a"], {2, 3, 4, 5}, 7)
  {{47, 3, 4, 5}, 7}
  """
  def execute_instruction(["cpy", value, letter], state, index) do
    new_state = put_elem(state, register(letter), register_val(state, value))
    {new_state, index+1}
  end

  @doc """
  iex> Advent.Day12.execute_instruction(["jnz", "a", "2"], {2, 3, 4, 5}, 2)
  {{2, 3, 4, 5}, 4}

  iex> Advent.Day12.execute_instruction(["jnz", "a", "-1"], {0, 3, 4, 5}, 2)
  {{0, 3, 4, 5}, 3}

  iex> Advent.Day12.execute_instruction(["jnz", "1", "2"], {2, 3, 4, 5}, 2)
  {{2, 3, 4, 5}, 4}

  iex> Advent.Day12.execute_instruction(["jnz", "0", "-1"], {2, 3, 4, 5}, 2)
  {{2, 3, 4, 5}, 3}
  """
  def execute_instruction(["jnz", letter, move], state, index) do
    case register_val(state, letter) do
      0     -> {state, index+1}
      _     -> {state, index+String.to_integer(move)}
    end
  end

  def input do
    File.read!("test/fixtures/day_12") |> String.trim |> String.split("\n")
  end

  def register(key) do
    %{"a" => 0, "b" => 1, "c" => 2, "d" => 3}[key]
  end

  def register_val(state, letter) when letter in ["a", "b", "c", "d"], do: elem(state, register(letter))
  def register_val(_, letter), do: String.to_integer(letter)
end

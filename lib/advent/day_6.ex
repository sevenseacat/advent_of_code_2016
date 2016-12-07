defmodule Advent.Day6 do
  @doc """
  iex> Advent.Day6.unjammer(["eedadn", "drvtee", "eandsr", "raavrd", "atevrs",
  ...>  "tsrnev", "sdttsa", "rasrtv", "nssdts", "ntnada", "svetve", "tesnvt",
  ...>  "vntsnd", "vrdear", "dvrsen", "enarar"])
  "easter"
  """
  def unjammer(input) do
    do_unjammer(input, &Enum.max_by/2)
  end

  @doc """
  iex> Advent.Day6.unlikely_unjammer(["eedadn", "drvtee", "eandsr", "raavrd", "atevrs",
  ...>  "tsrnev", "sdttsa", "rasrtv", "nssdts", "ntnada", "svetve", "tesnvt",
  ...>  "vntsnd", "vrdear", "dvrsen", "enarar"])
  "advent"
  """
  def unlikely_unjammer(input) do
    do_unjammer(input, &Enum.min_by/2)
  end

  def do_unjammer(input, sorter) do
    key_length = hd(input) |> String.length
    accumulator = Map.new(for i <- 1..key_length, do: {i, %{}})
    frequency_table(input, accumulator)
    |> Map.values
    |> Enum.map(fn list ->
      list
      |> sorter.(fn({_key, val}) -> val end)
      |> elem(0)
    end)
    |> to_string
  end

  def frequency_table([], acc), do: acc
  def frequency_table([word | words], acc) do
    frequency_table(words, add_word_frequency(String.graphemes(word), 1, acc))
  end

  def add_word_frequency([], _position, acc), do: acc
  def add_word_frequency([letter | letters], position, acc) do
    acc = Map.update!(acc, position, fn(position_frequency) ->
      Map.update(position_frequency, letter, 1, &(&1+1))
    end)

    add_word_frequency(letters, position+1, acc)
  end

  def input do
    File.read!("test/fixtures/day_6") |> String.split
  end
end

defmodule Advent.Day6 do
  @doc """
  iex> Advent.Day6.unjammer(["eedadn", "drvtee", "eandsr", "raavrd", "atevrs",
  ...>  "tsrnev", "sdttsa", "rasrtv", "nssdts", "ntnada", "svetve", "tesnvt",
  ...>  "vntsnd", "vrdear", "dvrsen", "enarar"])
  "easter"
  """
  def unjammer(input) do
    do_unjammer(input, &likely_sorter/1)
  end

  @doc """
  iex> Advent.Day6.unlikely_unjammer(["eedadn", "drvtee", "eandsr", "raavrd", "atevrs",
  ...>  "tsrnev", "sdttsa", "rasrtv", "nssdts", "ntnada", "svetve", "tesnvt",
  ...>  "vntsnd", "vrdear", "dvrsen", "enarar"])
  "advent"
  """
  def unlikely_unjammer(input) do
    do_unjammer(input, &unlikely_sorter/1)
  end

  def do_unjammer(input, sorter) do
    key_length = hd(input) |> String.length
    accumulator = Map.new(for i <- 1..key_length, do: {i, %{}})
    frequency_table(input, accumulator)
    |> Map.values
    |> Enum.map(fn list ->
      list
      |> sorter.()
      |> List.first
      |> elem(0)
    end)
    |> to_string
  end

  @doc """
  How to sort the frequency tables for the two different types of unjammer.
  """
  def likely_sorter(list),   do: Enum.sort(list, fn({_, first}, {_, second}) -> first >= second end)
  def unlikely_sorter(list), do: Enum.sort(list, fn({_, first}, {_, second}) -> first <= second end)

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

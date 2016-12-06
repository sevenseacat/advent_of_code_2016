defmodule Advent.Day3 do
  def possible_triangle_count(input) do
    input
    |> Enum.count(&possible?/1)
  end

  @doc """
  Returns a sorted list of triangle sides.

  iex> Advent.Day3.input("3 4 5 6 7 8 9 10 11", &Advent.Day3.horizontal_chunk/1)
  [[3,4,5], [6,7,8], [9,10,11]]

  iex> Advent.Day3.input("3 4 5 6 7 8 9 10 11", &Advent.Day3.vertical_chunk/1)
  [[3,6,9], [4,7,10], [5,8,11]]
  """
  def input(data, fun) do
    data
    |> String.trim
    |> String.split
    |> Enum.map(&(String.to_integer(&1)))
    |> fun.()
    |> Enum.map(&(Enum.sort(&1)))
  end

  def horizontal_chunk(list) do
    list
    |> Stream.chunk(3)
  end

  def vertical_chunk(list) do
    list
    |> do_vertical_chunk([[], [], []])
    |> Enum.chunk(3)
  end

  defp do_vertical_chunk([], results) do
    results
    |> Enum.map(&Enum.reverse/1)
    |> Enum.concat
  end

  defp do_vertical_chunk([a, b, c|tail], [as, bs, cs]) do
    do_vertical_chunk(tail, [[a|as], [b|bs], [c|cs]])
  end

  @doc """
  In a valid triangle, the sum of any two sides must be larger than the remaining side.

  iex> Advent.Day3.possible?([5,10,25])
  false

  iex> Advent.Day3.possible?([3,4,5])
  true
  """
  def possible?([a,b,c]) do
    (a+b > c) && (a+c > b) && (b+c > a)
  end
end

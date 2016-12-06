defmodule Advent.Day3 do
  def possible_triangle_count(input) do
    input
    |> Enum.count(&possible?/1)
  end

  @doc """
  Returns a sorted list of triangle sides, eg. [[1,2,3],[4,5,6],...]
  """
  def input do
    File.read!("test/fixtures/day_3")
    |> String.trim
    |> String.split("\n")
    |> Stream.map(fn(triangle) ->
        triangle
        |> String.split
        |> Stream.map(&(String.to_integer(&1)))
        |> Enum.sort
      end)
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

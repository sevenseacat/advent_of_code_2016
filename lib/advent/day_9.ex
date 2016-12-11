defmodule Advent.Day9 do
  @doc """
  iex> Advent.Day9.decompress("ADVENT")
  "ADVENT"

  iex> Advent.Day9.decompress("A(1x5)BC")
  "ABBBBBC"

  iex> Advent.Day9.decompress("(3x3)XYZ")
  "XYZXYZXYZ"

  iex> Advent.Day9.decompress("A(2x2)BCD(2x2)EFG")
  "ABCBCDEFEFG"

  iex> Advent.Day9.decompress("(6x1)(1x3)A")
  "(1x3)A"

  iex> Advent.Day9.decompress("X(8x2)(3x3)ABCY")
  "X(3x3)ABC(3x3)ABCY"
  """
  def decompress(string) do
    case String.split(string, "(", parts: 2) do
      [string] -> string
      [content, string] -> content <> duplicate_via_marker(string)
    end
  end

  defp duplicate_via_marker(string) do
    case String.split(string, ")", parts: 2) do
      [string] -> string
      [marker, string] ->
        [dup_length, dup_count] = String.split(marker, "x") |> Enum.map(&String.to_integer/1)

        {content_to_dup, rest} = String.split_at(string, dup_length)
        String.duplicate(content_to_dup, dup_count) <> decompress(rest)
    end
  end

  def input do
    File.read!("test/fixtures/day_9") |> String.trim
  end
end
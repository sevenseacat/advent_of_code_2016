defmodule Advent.Day4 do
  def real_room_sector_sum do
    list_from_file
    |> Stream.map(&parse_room_details/1)
    |> Stream.reject(&(!real_room?(&1)))
    |> Stream.map(&(&1["sector"]))
    |> Enum.sum
  end

  def list_from_file do
    File.read!("test/fixtures/day_4") |> String.split
  end

  @doc """
  iex> Advent.Day4.parse_room_details("aaaaa-bbb-z-y-x-123[abxyz]")
  %{"name" => "aaaaa-bbb-z-y-x", "sector" => 123, "checksum" => "abxyz",
    "letter_frequency" => [a: 5, b: 3, x: 1, y: 1, z: 1]}

  iex> Advent.Day4.parse_room_details("a-b-c-d-e-f-g-h-987[abcde]")
  %{"name" => "a-b-c-d-e-f-g-h", "sector" => 987, "checksum" => "abcde",
    "letter_frequency" => [a: 1, b: 1, c: 1, d: 1, e: 1, f: 1, g: 1, h: 1]}

  iex> Advent.Day4.parse_room_details("not-a-real-room-404[oarel]")
  %{"name" => "not-a-real-room", "sector" => 404, "checksum" => "oarel",
    "letter_frequency" => [a: 2, e: 1, l: 1, m: 1, n: 1, o: 3, r: 2, t: 1]}

  iex> Advent.Day4.parse_room_details("totally-real-room-200[decoy]")
  %{"name" => "totally-real-room", "sector" => 200, "checksum" => "decoy",
    "letter_frequency" => [a: 2, e: 1, l: 3, m: 1, o: 3, r: 2, t: 2, y: 1]}
  """
  def parse_room_details(room) do
    details = Regex.named_captures(~r/^(?P<name>[a-z\-]+)\-(?P<sector>\d+)\[(?P<checksum>[a-z]+)\]$/, room)
    details
    |> Map.put("sector", String.to_integer(details["sector"]))
    |> Map.put("letter_frequency", letter_frequency(details["name"]))
  end

  defp letter_frequency(name) do
    name
    |> String.replace("-", "")
    |> String.to_charlist
    |> Enum.sort
    |> Enum.chunk_by(&(&1))
    |> Enum.map(fn(letters) -> {List.to_atom([List.first(letters)]), length(letters)} end)
  end

  @doc """
  iex> Advent.Day4.real_room?(%{"checksum" => "oarel",
  ...> "letter_frequency" => [a: 2, e: 1, l: 1, m: 1, n: 1, o: 3, r: 2, t: 1]})
  true

  iex> Advent.Day4.real_room?(%{"checksum" => "decoy",
  ...> "letter_frequency" => [a: 2, e: 1, l: 3, m: 1, o: 3, r: 2, t: 2, y: 1]})
  false
  """
  def real_room?(room) do
    calculated_checksum = room["letter_frequency"]
    |> Enum.sort(fn({_, first}, {_, second}) -> first >= second end)
    |> Dict.keys
    |> Enum.take(5)
    |> Enum.map(&to_string/1)
    |> to_string

    calculated_checksum == room["checksum"]
  end
end

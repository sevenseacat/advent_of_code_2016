defmodule Advent.Day14 do
  alias Advent.Day14.Cache

  @salt "zpqevtbw"

  def part1 do
    Cache.start_link
    look_for_key(0, %{}, &hash/2)
  end

  def part2 do
    Cache.start_link
    look_for_key(0, %{}, &super_hash/2)
  end

  def look_for_key(index, keys, _hash_fn) when map_size(keys) == 64, do: index-1
  def look_for_key(index, keys, hash_fn) do
    case key?(index, @salt, hash_fn) do
      true ->
        IO.puts "Found key #{map_size(keys)+1}: #{index}"
        look_for_key(index+1, Map.put_new(keys, index, true), hash_fn)
      false -> look_for_key(index+1, keys, hash_fn)
    end
  end

  @doc """
  iex> Day14.key?(18, "abc", &Day14.hash/2)
  false # has triple but is not key

  iex> Day14.key?(38, "abc", &Day14.hash/2)
  false

  iex> Day14.key?(39, "abc", &Day14.hash/2)
  true

  iex> Day14.key?(40, "abc", &Day14.hash/2)
  false

  iex> Day14.key?(5, "abc", &Day14.super_hash/2)
  false # triple but not key

  iex> Day14.key?(10, "abc", &Day14.super_hash/2)
  true

  iex> Day14.key?(11, "abc", &Day14.super_hash/2)
  false

  iex> Day14.key?(22551, "abc", &Day14.super_hash/2)
  true
  """
  def key?(index, salt, hash_fn) do
    {is_triple, letter} = Cache.hash(index, salt, hash_fn) |> is_triple?

    is_triple && check_for_five_char_sequence(index, salt, letter, hash_fn)
  end

  def is_triple?(string) do
    case Regex.run(~r/([a-z0-9])\1\1/, string) do
      nil -> {false, nil}
      [_triple, single] -> {true, single}
    end
  end

  def check_for_five_char_sequence(index, salt, letter, hash_fn) do
    Enum.any?(index+1..index+1000, fn(new_index) ->
      Cache.hash(new_index, salt, hash_fn) |> has_five_char_sequence?(letter)
    end)
  end

  @doc """
  iex> Day14.has_five_char_sequence?("abc123", "a")
  false

  iex> Day14.has_five_char_sequence?("abcaaaaa123", "a")
  true
  """
  def has_five_char_sequence?(string, letter) do
    String.contains?(string, String.duplicate(letter, 5))
  end

  @doc """
  iex> Day14.hash("abc18") |> String.contains?("cc38887a5")
  true
  """
  def hash(index, salt), do: hash("#{salt}#{index}")
  def hash(string), do: :crypto.hash(:md5, string) |> Base.encode16 |> String.downcase

  @doc """
  iex> Day14.super_hash(0, "abc")
  "a107ff634856bb300138cac6568c0f24"
  """
  def super_hash(index, salt), do: "#{salt}#{index}" |> do_super_hash(0)
  def do_super_hash(string, 2017), do: string
  def do_super_hash(string, index), do: string |> hash |> do_super_hash(index+1)
end

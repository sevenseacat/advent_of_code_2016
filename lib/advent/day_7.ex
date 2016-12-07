defmodule Advent.Day7 do
  import Integer, only: [is_odd: 1]

  def tls_addresses(input) do
    input
    |> Stream.reject(&(!tls_address?(&1)))
    |> Enum.count
  end

  def input do
    File.read!("test/fixtures/day_7") |> String.split
  end

  @doc """
  iex> Advent.Day7.tls_address?("abba[mnop]qrst")
  true

  iex> Advent.Day7.tls_address?("abcd[bddb]xyyx")
  false

  iex> Advent.Day7.tls_address?("aaaa[qwer]tyui")
  false

  iex> Advent.Day7.tls_address?("ioxxoj[asdfgh]zxcvbn")
  true

  This wasn't part of the examples, but some of the input has multiple [] blocks
  which choked my first attempt at a solution.
  iex> Advent.Day7.tls_address?("ioxxoj[asdfgh]zxcvbn[asdfgh]zxcvbn")
  true
  """
  def tls_address?(address) do
    address
    |> String.split(["[", "]"])
    |> check_tls_address(0, false)
  end

  def check_tls_address([], _position, truthy), do: truthy
  def check_tls_address([head | tail], position, truthy) do
    abba = ~r/(\w)((?!\1)\w)\2\1/

    case String.match?(head, abba) do
      true ->
        case is_odd(position) do
          true -> false
          false -> check_tls_address(tail, position+1, true)
        end
      false -> check_tls_address(tail, position+1, truthy)
    end
  end
end

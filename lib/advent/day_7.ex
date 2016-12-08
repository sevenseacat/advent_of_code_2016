defmodule Advent.Day7 do
  def tls_addresses(input) do
    input
    |> Stream.reject(&(!tls_address?(&1)))
    |> Enum.count
  end

  def ssl_addresses(input) do
    input
    |> Stream.reject(&(!ssl_address?(&1)))
    |> Enum.count
  end

  def input do
    File.read!("test/fixtures/day_7") |> String.split
  end

  @doc """
  iex> Advent.Day7.ssl_address?("aba[bab]xyz")
  true

  iex> Advent.Day7.ssl_address?("xyx[xyx]xyx")
  false

  iex> Advent.Day7.ssl_address?("aaa[kek]eke")
  true

  iex> Advent.Day7.ssl_address?("zazbz[bzb]cdb")
  true
  """
  def ssl_address?(address), do: check_ssl_address(String.graphemes(address), address)

  def check_ssl_address([], _string), do: false
  def check_ssl_address([a, b, a | tail], string) when a >= "a" and a <= "z" and b >= "a" and b <= "z" and a != b do
    case String.match?(string, ~r/\[\w*#{b}#{a}#{b}\w*\]/) do
      true -> true
      false -> check_ssl_address([b, a | tail], string)
    end
  end

  # Have hit the start of a hypernet section - skip to the end of it to keep parsing
  def check_ssl_address([ "[" | tail], string) do
    tail
    |> Enum.split_while(&(&1 != "]"))
    |> elem(1)
    |> check_ssl_address(string)
  end
  def check_ssl_address([_head | tail], string), do: check_ssl_address(tail, string)

  @doc """
  iex> Advent.Day7.tls_address?("abba[mnop]qrst")
  true

  iex> Advent.Day7.tls_address?("abcd[bddb]xyyx")
  false

  iex> Advent.Day7.tls_address?("aaaa[qwer]tyui")
  false

  iex> Advent.Day7.tls_address?("ioxxoj[asdfgh]zxcvbn")
  true

  Some more examples to flesh out edge cases that the original tests didn't cover.
  iex> Advent.Day7.tls_address?("ioxxoj[asdfgh]zxcvbn[asdfgh]zxcvbn")
  true

  iex> Advent.Day7.tls_address?("ioxxoj[abcoxxoabc]zxcvbn[asdfgh]zxcvbn")
  false
  """
  def tls_address?(address) do
    abba = "(\\w)((?!\\1)\\w)\\2\\1"

    case String.match?(address, ~r/\[\w*#{abba}\w*\]/) do
      # If there is an ABBA in the hypernet [] parts, it's all over.
      true -> false
      # But if not, and there's an ABBA anywhere in the string, it's a win.
      false -> String.match?(address, ~r/#{abba}/)
    end
  end
end

defmodule Advent.Day7 do
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

defmodule Advent.Day5 do
  @input "uqwqemis"

  @doc """
  iex> Advent.Day5.basic_password("abc")
  "18F47A30"
  """
  def basic_password(input \\ @input) do
    brute_force(input, 0, "")
  end

  defp brute_force(_input, _counter, <<password::binary-size(8)>>), do: String.reverse(password)
  defp brute_force(input, counter, password) do
    password = case :crypto.hash(:md5, "#{input}#{counter}") |> Base.encode16 do
      <<"00000", rest::binary>> -> String.first(rest) <> password
      _                         -> password
    end

    brute_force(input, counter+1, password)
  end
end

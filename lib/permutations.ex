defmodule Permutations do
  @moduledoc """
  Adapted from http://rosettacode.org/wiki/Permutations#Elixir.
  """
  def of(_, 0), do: [[]]
  def of([], _max), do: [[]]
  def of(list, max) do
    for x <- list, y <- of(list -- [x], max-1), do: [x|y]
  end
end

defmodule Advent.Day14Test do
  use ExUnit.Case
  alias Advent.Day14
  alias Advent.Day14.Cache

  setup do
    Cache.start_link
    :ok
  end

  doctest Advent.Day14
end

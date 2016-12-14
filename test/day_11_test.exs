defmodule Advent.Day11Test do
  use ExUnit.Case
  doctest Advent.Day11

  test "calculating legal moves for a given state" do
    expected = [
      {[f1: {[:s], []}, f2: {[:r], [:s, :r]}, f3: {[], []}], :f1},
      {[f1: {[:r], []}, f2: {[:s], [:s, :r]}, f3: {[], []}], :f1},
      {[f1: {[:s], [:s]}, f2: {[:r], [:r]}, f3: {[], []}], :f1},
      {[f1: {[:r], [:r]}, f2: {[:s], [:s]}, f3: {[], []}], :f1},
      {[f1: {[:s, :r], []}, f2: {[], [:s, :r]}, f3: {[], []}], :f1},
      {[f1: {[], []}, f2: {[:r], [:s, :r]}, f3: {[:s], []}], :f3},
      {[f1: {[], []}, f2: {[:s], [:s, :r]}, f3: {[:r], []}], :f3},
      {[f1: {[], []}, f2: {[:r], [:r]}, f3: {[:s], [:s]}], :f3},
      {[f1: {[], []}, f2: {[:s], [:s]}, f3: {[:r], [:r]}], :f3},
      {[f1: {[], []}, f2: {[], [:s, :r]}, f3: {[:s, :r], []}], :f3}
    ]

    assert Advent.Day11.legal_moves({[f1: {[], []},
      f2: {[:s, :r], [:s, :r]}, f3: {[], []}], :f2}) == expected
  end
end

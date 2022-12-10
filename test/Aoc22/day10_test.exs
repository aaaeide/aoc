defmodule Aoc22.Day10Test do
  use ExUnit.Case
  import Aoc22.Day10, only: [part1: 1]

  test "part 1" do
    assert part1("inputs/22/t10.txt") == 13140
  end
end

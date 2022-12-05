defmodule Aoc22.Day05Test do
  use ExUnit.Case
  import Aoc22.Day05, only: [solve: 1, parse: 1]

  test "parse" do
    assert parse("inputs/22/t5.txt") == {
             %{1 => 'NZ', 2 => 'DCM', 3 => 'P'},
             [[1, 2, 1], [3, 1, 3], [2, 2, 1], [1, 1, 2]]
           }
  end

  test "part 1" do
    assert parse("inputs/22/t5.txt") |> solve() == 'CMZ'
  end
end

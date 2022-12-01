defmodule Day082Test do
  use ExUnit.Case
  import Aoc21.Day082, only: [permute: 1]

  test "permutes" do
    assert permute([1, 2, 3]) == [
             [1, 2, 3],
             [1, 3, 2],
             [2, 1, 3],
             [2, 3, 1],
             [3, 1, 2],
             [3, 2, 1]
           ]
  end
end

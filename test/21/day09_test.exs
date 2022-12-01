defmodule Day09Test do
  use ExUnit.Case
  import Aoc21.Input, only: [readlines: 2]
  import Aoc21.Day09, only: [find_lowpoint_score: 1, do_part2: 1]

  setup_all do
    [heightmap: readlines("t9.txt", as: [:integer])]
  end

  test "reads input properly", fixture do
    assert hd(fixture.heightmap) == [2, 1, 9, 9, 9, 4, 3, 2, 1, 0]
  end

  test "finds lowpoint score", fixture do
    assert fixture.heightmap |> find_lowpoint_score() == 15
  end

  test "finds basin product", fixture do
    assert fixture.heightmap |> do_part2 == 1134
  end
end

defmodule Day05Test do
  use ExUnit.Case
  import Aoc21.Input, only: [read_line_segments: 1]
  import Aoc21.Day05, only: [find_overlaps: 1]

  setup_all do
    [lines: read_line_segments("t5.txt")]
  end

  test "reads input properly", fixture do
    assert hd(fixture.lines) == {{0, 9}, {5, 9}}
  end

  test "find number of overlapping lines", fixture do
    # assert find_overlaps(fixture.lines) == 5 <-- Part 1
    assert find_overlaps(fixture.lines) == 12
  end
end

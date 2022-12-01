defmodule Day07Test do
  use ExUnit.Case
  import Aoc21.Input, only: [readlines: 3]
  import Aoc21.Day07, only: [cheapest_align_linear: 1, cheapest_align_increasing: 1]

  setup_all do
    [positions: readlines("t7.txt", ",", as: :integer)]
  end

  test "finds cheapest align cost", fixture do
    assert cheapest_align_linear(fixture.positions) == 37
  end

  test "finds cheapest align cost part 2", fixture do
    assert cheapest_align_increasing(fixture.positions) == 168
  end
end

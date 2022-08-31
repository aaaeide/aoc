defmodule Day11Test do
  use ExUnit.Case
  import Aoc21.Input, only: [readlines: 2]
  import Aoc21.Day11, only: [increment_cells: 2, increment_cells: 1]

  setup_all do
    [grid: readlines("t9.txt", as: [:integer])]
  end

  test "increments all cells" do
    assert [
      [1, 1, 1, 1, 1],
      [1, 8, 8, 8, 1],
      [1, 8, 1, 8, 1],
      [1, 8, 8, 8, 1],
      [1, 1, 1, 1, 1]
    ]
    |> increment_cells() == [
      [2, 2, 2, 2, 2],
      [2, 9, 9, 9, 2],
      [2, 9, 2, 9, 2],
      [2, 9, 9, 9, 2],
      [2, 2, 2, 2, 2]
    ]
  end

  test "increments some cells" do
    assert [
      [1, 1, 1, 1, 1],
      [1, 8, 8, 8, 1],
      [1, 8, 1, 8, 1],
      [1, 8, 8, 8, 1],
      [1, 1, 1, 1, 1]
    ]
    |> increment_cells(MapSet.new([{0,0}, {0,1}, {1,0}, {1,1}])) == [
      [2, 2, 1, 1, 1],
      [2, 9, 8, 8, 1],
      [1, 8, 1, 8, 1],
      [1, 8, 8, 8, 1],
      [1, 1, 1, 1, 1]
    ]
  end
end

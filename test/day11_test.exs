defmodule Day11Test do
  use ExUnit.Case
  import Aoc21.Input, only: [readlines: 2]
  import Aoc21.Day11, only: [update_cells: 1]

  # setup_all do
  #   [grid: readlines("t9.txt", as: [:integer])]
  # end

  test "simulates one step correctly" do
    assert [
             [1, 1, 1, 1, 1],
             [1, 9, 9, 9, 1],
             [1, 9, 1, 9, 1],
             [1, 9, 9, 9, 1],
             [1, 1, 1, 1, 1]
           ]
           |> update_cells() == [
             [3, 4, 5, 4, 3],
             [4, 0, 0, 0, 4],
             [5, 0, 0, 0, 5],
             [4, 0, 0, 0, 4],
             [3, 4, 5, 4, 3]
           ]
  end

  @tag :skip
  test "simulates two steps correctly" do
    assert [
             [1, 1, 1, 1, 1],
             [1, 9, 9, 9, 1],
             [1, 9, 1, 9, 1],
             [1, 9, 9, 9, 1],
             [1, 1, 1, 1, 1]
           ]
           |> update_cells()
           |> update_cells() ==
             [
               [4, 5, 6, 5, 4],
               [5, 1, 1, 1, 5],
               [6, 1, 1, 1, 6],
               [5, 1, 1, 1, 5],
               [4, 5, 6, 5, 4]
             ]
  end
end

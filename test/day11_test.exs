defmodule Day11Test do
  use ExUnit.Case
  import Aoc21.Input, only: [readlines: 2]

  import Aoc21.Day11,
    only: [increment_cells: 2, increment_cells: 1, get_neighbs: 1, get_cells_above: 2, step: 2]

  setup_all do
    [grid: readlines("t11.txt", as: [:integer])]
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

  test "increments neighbors of {0,0}" do
    assert [
             [1, 1, 1, 1, 1],
             [1, 8, 8, 8, 1],
             [1, 8, 1, 8, 1],
             [1, 8, 8, 8, 1],
             [1, 1, 1, 1, 1]
           ]
           |> increment_cells(get_neighbs({0, 0})) == [
             [1, 2, 1, 1, 1],
             [2, 9, 8, 8, 1],
             [1, 8, 1, 8, 1],
             [1, 8, 8, 8, 1],
             [1, 1, 1, 1, 1]
           ]
  end

  test "finds squares above 10" do
    assert [
             [1, 1, 1, 1, 1],
             [1, 8, 8, 8, 1],
             [1, 8, 11, 8, 1],
             [1, 8, 8, 8, 1],
             [1, 1, 1, 1, 1]
           ]
           |> get_cells_above(10) == MapSet.new([{2, 2}])
  end

  test "finds correct number of flashes after 10 steps", fixture do
    {_, flash_cnt} = fixture.grid |> step(10)
    assert flash_cnt == 204
  end
end

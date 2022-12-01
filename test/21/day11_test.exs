defmodule Day11Test do
  use ExUnit.Case
  import Aoc21.Input, only: [readlines: 2]

  import Aoc21.Day11,
    only: [update_cells: 2, get_neighbs: 1, get_cells_above: 2, step_n: 2]

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
           |> update_cells(fn _coord, val -> val + 1 end) == [
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
           |> update_cells(fn coord, val ->
             if coord in get_neighbs({0, 0}), do: val + 1, else: val
           end) ==
             [
               [1, 2, 1, 1, 1],
               [2, 9, 8, 8, 1],
               [1, 8, 1, 8, 1],
               [1, 8, 8, 8, 1],
               [1, 1, 1, 1, 1]
             ]
  end

  test "resets cell values > 9" do
    assert [
             [1, 1, 1, 1, 1],
             [1, 10, 10, 10, 1],
             [1, 10, 1, 10, 1],
             [1, 10, 10, 10, 1],
             [1, 1, 1, 1, 1]
           ]
           |> update_cells(fn coord, val ->
             if val > 9 do
               0
             else
               val
             end
           end) ==
             [
               [1, 1, 1, 1, 1],
               [1, 0, 0, 0, 1],
               [1, 0, 1, 0, 1],
               [1, 0, 0, 0, 1],
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
    {_, flash_cnt} = fixture.grid |> step_n(10)
    assert flash_cnt == 204
  end
end

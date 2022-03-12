defmodule Aoc21.Day11 do
  # import Aoc21.Input, only: [readlines: 2]
  import Aoc21.Day09, only: [get_neighbors: 3, at: 3]

  def update_cells(grid), do: update_cells(grid, true)
  def update_cells(grid, false), do: grid

  def update_cells(grid, true) do
    sidelength = length(grid) - 1
    continue? = false

    0..sidelength
    |> Enum.reduce([], fn y, rows ->
      [
        0..sidelength
        |> Enum.reduce([], fn x, row ->
          updated = (grid |> at(x, y)) + 1
          continue? = true
          [updated | row]
        end)
        |> Enum.reverse()
        | rows
      ]
    end)
    |> Enum.reverse()
    |> update_cells(continue?)
  end
end

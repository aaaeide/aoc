defmodule Aoc21.Day11 do
  @type grid :: [[integer()]]
  @type coord :: {integer(), integer()}
  @type coordset :: MapSet.t({integer(), integer()})

  import Aoc21.Input, only: [readlines: 2]

  @spec step_n(grid(), integer(), integer()) :: {grid(), integer()}
  def step_n(grid, n, cnt \\ 0)

  def step_n(grid, 0, flash_cnt), do: {grid, flash_cnt}

  def step_n(grid, n, flash_cnt) do
    {new_grid, num_new_flashes} =
      grid
      |> update_cells(fn _coord, val -> val + 1 end)
      |> cascade(MapSet.new(), MapSet.new())

    # reset cells whose value is greater than 9
    new_grid =
      new_grid
      |> update_cells(fn _coord, val ->
        if val > 9 do
          0
        else
          val
        end
      end)

    step_n(new_grid, n - 1, flash_cnt + num_new_flashes)
  end

  def step_until(grid, stop_when_true, step_cnt) do
    {new_grid, _num_new_flashes} =
      grid
      |> update_cells(fn _coord, val -> val + 1 end)
      |> cascade(MapSet.new(), MapSet.new())

    # reset cells whose value is greater than 9
    new_grid =
      new_grid
      |> update_cells(fn _coord, val ->
        if val > 9 do
          0
        else
          val
        end
      end)

    if stop_when_true.(new_grid) do
      step_cnt
    else
      step_until(new_grid, stop_when_true, step_cnt + 1)
    end
  end

  @spec cascade(grid(), coordset(), coordset(), integer() | nil) :: {grid(), integer()}
  def cascade(grid, all_flashed, new_flashed, num_new_flashed \\ nil)

  def cascade(grid, all_flashed, _new_flashed, 0),
    do: {grid, MapSet.size(all_flashed)}

  def cascade(grid, all_flashed, new_flashed, _num_new_flashed) do
    # find all cells that need to be incremented and by how much
    to_inc =
      new_flashed
      |> Enum.map(&get_neighbs/1)
      |> Enum.reduce(%{}, fn coordset, map ->
        coordset
        |> Enum.reduce(map, fn coord, map ->
          Map.update(map, coord, 1, fn cur -> cur + 1 end)
        end)
      end)

    # increment cells
    grid =
      grid
      |> update_cells(fn coord, val ->
        if Map.has_key?(to_inc, coord) do
          val + to_inc[coord]
        else
          val
        end
      end)

    # figure out which cells flashed this round by comparing w old all_flashed
    new_all_flashed = grid |> get_cells_above(9)
    new_flashed = new_all_flashed |> MapSet.difference(all_flashed)

    # recurse
    cascade(grid, new_all_flashed, new_flashed, MapSet.size(new_flashed))
  end

  def update_cells(grid, func) do
    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {val, x} -> func.({x, y}, val) end)
    end)
  end

  @spec get_neighbs(coord()) :: coordset()
  def get_neighbs({x, y}) do
    [
      {x - 1, y - 1},
      {x, y - 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1},
      {x, y + 1},
      {x - 1, y + 1},
      {x - 1, y}
    ]
    |> Enum.filter(fn {x, y} -> 0 <= x and x < 10 and 0 <= y and y < 10 end)
    |> MapSet.new()
  end

  @spec get_cells_above(grid(), integer()) :: coordset()
  def get_cells_above(grid, thresh) do
    grid
    |> Enum.with_index()
    |> Enum.reduce(MapSet.new(), fn {row, y}, set ->
      row
      |> Enum.with_index()
      |> Enum.reduce(set, fn {val, x}, set ->
        if val > thresh do
          MapSet.put(set, {x, y})
        else
          set
        end
      end)
    end)
  end

  def all_zero_grid(grid) do
    grid |> List.flatten() |> MapSet.new() == MapSet.new([0])
  end

  def part1() do
    {_, flash_cnt} =
      readlines("i11.txt", as: [:integer])
      |> step_n(100)

    IO.puts(flash_cnt)
  end

  def part2() do
    readlines("i11.txt", as: [:integer])
    |> step_until(&all_zero_grid/1, 1)
    |> IO.puts()
  end
end

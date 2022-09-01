defmodule Aoc21.Day11 do
  @type grid :: [[integer()]]
  @type coord :: {integer(), integer()}
  @type coordset :: MapSet.t({integer(), integer()})

  @spec step(grid(), integer(), integer()) :: {grid(), integer()}
  def step(grid, n, cnt \\ 0)

  def step(grid, 0, flash_cnt), do: {grid, flash_cnt}

  def step(grid, n, flash_cnt) do
    {new_grid, num_new_flashes} =
      grid
      |> increment_cells
      |> cascade(MapSet.new(), MapSet.new())

    step(new_grid, n - 1, flash_cnt + num_new_flashes)
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
    new_grid =
      grid
      |> Enum.with_index()
      |> Enum.map(fn {row, y} ->
        row
        |> Enum.with_index()
        |> Enum.map(fn {val, x} ->
          if Map.has_key?(to_inc, {x, y}) do
            val + to_inc[{x, y}]
          else
            val
          end
        end)
      end)

    # figure out which cells flashed this round by comparing w old all_flashed
    new_all_flashed = new_grid |> get_cells_above(9)
    new_flashed = new_all_flashed |> MapSet.difference(all_flashed)

    # recurse
    cascade(new_grid, new_all_flashed, new_flashed, MapSet.size(new_flashed))
  end

  @spec increment_cells(grid(), coordset()) :: grid()
  def increment_cells(grid, which) do
    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {val, x} ->
        if {x, y} in which do
          val + 1
        else
          val
        end
      end)
    end)
  end

  @spec increment_cells(grid()) :: grid()
  def increment_cells(grid) do
    grid
    |> Enum.map(fn row ->
      row |> Enum.map(fn val -> val + 1 end)
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
end

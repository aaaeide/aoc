defmodule Aoc21.Day11 do
  @spec step([[integer()]]) :: [[integer()]]
  def step(grid) do
    grid

  end

  @spec increment_cells([[integer()]], MapSet) :: list
  def increment_cells(grid, which) do
    grid
    |> Enum.with_index
    |> Enum.map(fn {row, y} ->
      row
      |> Enum.with_index
      |> Enum.map(fn {val, x} ->
        if {x, y} in which do
          val + 1
        else
          val
        end
      end)
    end)
  end

  @spec increment_cells([[integer()]]) :: list
  def increment_cells(grid) do
    grid
    |> Enum.map(fn row ->
      row |> Enum.map(fn val -> val + 1 end)
    end)
  end
end

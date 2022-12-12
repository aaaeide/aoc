defmodule Aoc22.Day12 do
  import Enum, only: [at: 2, filter: 2]
  def at(grid, x, y), do: grid |> at(y) |> at(x)

  def adj(grid, {x, y}, flt) do
    for(x <- (x - 1)..(x + 1), do: for(y <- (y - 1)..(y + 1), do: {x, y}))
    |> filter(&(&1 != {x, y}))
    |> filter(fn {x, y} -> x > 0 and y > 0 end)
    |> filter(fn {x, y} -> length(grid) > y and length(grid |> at(0)) > x end)
    |> filter(&flt.(&1, {x, y}, grid))
  end

  def not_too_steep({x_to, y_to}, {x_fr, y_fr}, grid) do
    at(grid, x_to, y_to) - at(grid, x_fr, y_fr) <= 1
  end

  def find_S_E(grid) do
    {grid, {s, e, _}} =
      grid
      |> Enum.with_index()
      |> Enum.map_reduce({nil, nil, grid}, fn {row, y}, acc ->
        row
        |> Enum.with_index()
        |> Enum.map_reduce(acc, fn {el, x}, {st, gl, gr} ->
          case el do
            83 -> {97, {{x, y}, gl, gr}}
            69 -> {122, {st, {x, y}, gr}}
            _ -> {el, {st, gl, gr}}
          end
        end)
      end)

    {grid, {s, e}}
  end

  def parse(path \\ "inputs/22/i12.txt") do
    File.read!(path)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
    |> find_S_E()
  end

  def bfs({grid, {s, e}}) do
    nil
  end
end

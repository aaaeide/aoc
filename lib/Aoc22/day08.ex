defmodule Aoc22.Day08 do
  def parse_grid(path) do
    File.read!(path)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line |> String.graphemes() |> Enum.map(&String.to_integer/1)
    end)
  end

  def at(grid, x, y), do: grid |> Enum.at(y) |> Enum.at(x)

  def num_visible(sightlines, grid) do
    sightlines
    |> Enum.map(fn line ->
      line
      |> Enum.reduce({MapSet.new(), -1}, fn {x, y}, {vis, big} ->
        if grid |> at(x, y) > big do
          {MapSet.put(vis, {x, y}), grid |> at(x, y)}
        else
          {vis, big}
        end
      end)
      |> elem(0)
    end)
    |> Enum.reduce(&MapSet.union/2)
    |> MapSet.size()
  end

  def scenic_score(sightlines, grid) do
    sightlines
    |> Enum.map(fn line ->
      line
      |> Enum.with_index()
      |> Enum.map(fn {{x1, y1}, i} ->
        Enum.slice(line, (i + 1)..-1)
        |> Enum.reduce_while(0, fn {x2, y2}, cnt ->
          if grid |> at(x1, y1) > grid |> at(x2, y2) do
            {:cont, cnt + 1}
          else
            {:halt, cnt + 1}
          end
        end)
        |> (&{{x1, y1}, &1}).()
      end)
    end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn {{x, y}, view}, map ->
      Map.update(map, {x, y}, view, &(&1 * view))
    end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.max()
  end

  def solve(solve_for, path \\ "inputs/22/i8.txt") do
    grid = parse_grid(path)

    {h, w} = {length(grid), length(hd(grid))}

    rows = for y <- 0..(h - 1), do: for(x <- 0..(w - 1), do: {x, y})
    cols = for x <- 0..(w - 1), do: for(y <- 0..(h - 1), do: {x, y})

    (rows ++ cols ++ Enum.map(rows, &Enum.reverse/1) ++ Enum.map(cols, &Enum.reverse/1))
    |> solve_for.(grid)
  end

  def part1(), do: solve(&num_visible/2) |> IO.puts()
  def part2(), do: solve(&scenic_score/2) |> IO.puts()
end

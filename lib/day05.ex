defmodule Aoc21.Day05 do
  import Aoc21.Input, only: [read_line_segments: 1]

  def find_overlaps(lines) do
    lines
    |> Enum.reduce(%{}, &update_map(&1, &2))
    |> Map.values()
    |> Enum.count(&(&1 > 1))
  end

  def update_map({{x, y1}, {x, y2}}, map) do
    y1..y2
    |> Enum.reduce(map, fn y, accmap ->
      Map.update(accmap, {x, y}, 1, fn val -> val + 1 end)
    end)
  end

  def update_map({{x1, y}, {x2, y}}, map) do
    x1..x2
    |> Enum.reduce(map, fn x, accmap ->
      Map.update(accmap, {x, y}, 1, fn val -> val + 1 end)
    end)
  end

  # comment out this for part 1
  def update_map({{x1, y1}, {x2, y2}}, map) when abs(x1 - x2) == abs(y1 - y2) do
    Enum.zip(x1..x2, y1..y2)
    |> Enum.reduce(map, fn {x, y}, accmap ->
      Map.update(accmap, {x, y}, 1, fn val -> val + 1 end)
    end)
  end

  def update_map(_, map), do: map

  def solve() do
    read_line_segments("i5.txt")
    |> find_overlaps()
    |> IO.puts()
  end
end

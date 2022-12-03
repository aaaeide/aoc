defmodule Aoc22.Day03 do
  defp pri(x) when ?a <= x and x <= ?z, do: x - 96
  defp pri(x) when ?A <= x and x <= ?Z, do: x - 38

  defp read_rucksacks() do
    File.read!("inputs/22/i3.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
  end

  def part1() do
    read_rucksacks()
    |> Enum.map(&Enum.split(&1, div(length(&1), 2)))
    |> Enum.map(fn {l, r} ->
      MapSet.intersection(MapSet.new(l), MapSet.new(r))
      |> Enum.map(&pri/1)
    end)
    |> List.flatten()
    |> Enum.sum()
    |> IO.puts()
  end

  def part2() do
    read_rucksacks()
    |> Enum.chunk_every(3)
    |> Enum.map(fn group ->
      group
      |> Enum.map(&MapSet.new/1)
      |> Enum.reduce(&MapSet.intersection(&1, &2))
      |> Enum.map(&pri/1)
    end)
    |> List.flatten()
    |> Enum.sum()
    |> IO.puts()
  end
end

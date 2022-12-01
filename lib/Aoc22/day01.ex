defmodule Aoc22.Day01 do
  def solve() do
    File.read!("inputs/i1.txt")
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(fn elf ->
      elf |> String.split("\n") |> Enum.map(&String.to_integer/1) |> Enum.sum()
    end)
    |> Enum.sort()
    |> Enum.take(-3)
  end

  def part1(), do: solve() |> Enum.at(-1) |> IO.puts()
  def part2(), do: solve() |> Enum.sum() |> IO.puts()
end

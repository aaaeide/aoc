defmodule Aoc22.Day06 do
  def solve(size) do
    File.read!("inputs/22/i6.txt")
    |> String.to_charlist()
    |> Enum.chunk_every(size, 1)
    |> Enum.find_index(&(length(Enum.uniq(&1)) == size))
    |> (&IO.puts(&1 + size)).()
  end

  def part1(), do: solve(4)
  def part2(), do: solve(14)
end

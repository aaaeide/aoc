defmodule Aoc22.Day06 do
  import Enum, only: [find: 2, uniq: 1, slice: 2]

  defp find_marker(stream, size) do
    (size - 1)..length(stream)
    |> find(fn i -> uniq(slice(stream, (i - size + 1)..i)) |> length == size end)
    |> (&(&1 + 1)).()
  end

  def solve(size) do
    File.read!("inputs/22/i6.txt")
    |> String.to_charlist()
    |> find_marker(size)
    |> IO.puts()
  end

  def part1(), do: solve(4)
  def part2(), do: solve(14)
end

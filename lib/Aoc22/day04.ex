defmodule Aoc22.Day04 do
  def solve(filter_fn) do
    ptn = :binary.compile_pattern(["-", ","])

    File.read!("inputs/22/i4.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ptn))
    |> Enum.map(fn [l1, l2, r1, r2] ->
      {MapSet.new(String.to_integer(l1)..String.to_integer(l2)),
       MapSet.new(String.to_integer(r1)..String.to_integer(r2))}
    end)
    |> Enum.map(fn {m1, m2} -> {m1, m2, MapSet.intersection(m1, m2)} end)
    |> Enum.filter(&filter_fn.(&1))
    |> length()
    |> IO.puts()
  end

  def part1(), do: solve(fn {m1, m2, cap} -> m1 == cap or m2 == cap end)
  def part2(), do: solve(fn {_, _, cap} -> cap != MapSet.new() end)
end

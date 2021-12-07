defmodule Aoc21.Day07 do
  import Aoc21.Input, only: [readlines: 3]

  def cheapest_align_linear(positions) do
    with sorted <- positions |> Enum.sort(),
         median <- sorted |> Enum.at(div(length(sorted), 2)),
         costs <- sorted |> Enum.map(&abs(&1 - median)) do
      Enum.sum(costs)
    end
  end

  def cheapest_align_increasing(positions) do
    [
      do_cheapest_align_increasing(positions, &floor/1),
      do_cheapest_align_increasing(positions, &ceil/1)
    ]
    |> Enum.min()
  end

  defp do_cheapest_align_increasing(positions, rounder) do
    with x <- (Enum.sum(positions) / length(positions)) |> rounder.(),
         distances <- positions |> Enum.map(&abs(&1 - x)),
         costs <- distances |> Enum.map(&((&1 + 1) * (&1 / 2))) do
      Enum.sum(costs)
    end
  end

  def part1() do
    readlines("i7.txt", ",", as: :integer)
    |> cheapest_align_linear()
    |> IO.puts()
  end

  def part2() do
    readlines("i7.txt", ",", as: :integer)
    |> cheapest_align_increasing()
    |> IO.puts()
  end
end

defmodule Aoc21.Day01 do
  import Aoc21.Input, only: [readlines: 2]

  def count_depth_measurement_increase(measurements) do
    find_increase(measurements) |> Enum.sum()
  end

  def find_increase([a, b | rest]) when a < b, do: [1 | find_increase([b | rest])]
  def find_increase([a, b | rest]) when a >= b, do: [0 | find_increase([b | rest])]
  def find_increase(_), do: []

  def construct_sliding_window_sums([a, b, c | rest]) do
    [a + b + c | construct_sliding_window_sums([b, c | rest])]
  end

  def construct_sliding_window_sums(_), do: []

  def part1() do
    readlines("i1.txt", as: :integer)
    |> count_depth_measurement_increase()
    |> IO.puts()
  end

  def part2() do
    readlines("i1.txt", as: :integer)
    |> construct_sliding_window_sums()
    |> count_depth_measurement_increase()
    |> IO.puts()
  end
end

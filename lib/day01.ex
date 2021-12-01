defmodule Aoc21.Day01 do
  import Aoc21.Input, only: [readlines: 2]

  def count_depth_measurement_increase(measurements) do
    measurements
    |> Enum.reduce({0, :infinity}, fn depth, {count, prev} ->
      if depth > prev,
        do: {count + 1, depth},
        else: {count, depth}
    end)
    |> elem(0)
  end

  def construct_sliding_window_sums([a, b, c | []]), do: [a + b + c]

  def construct_sliding_window_sums([a, b, c | rest]) do
    [a + b + c | construct_sliding_window_sums([b, c | rest])]
  end

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

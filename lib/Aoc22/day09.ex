defmodule Aoc22.Day09 do
  def tail_move({xh, yh}, {xt, yt}) do
    cond do
      # Touching, tail is still
      abs(xh - xt) <= 1 and abs(yh - yt) <= 1 ->
        {xt, yt}

      # Two steps away along x axis
      abs(xh - xt) == 2 and yh == yt ->
        {div(xh + xt, 2), yt}

      # Two steps away along y axis
      xh == xt and abs(yh - yt) == 2 ->
        {xt, div(yh + yt, 2)}

      # Diagonal moves
      abs(xh - xt) == 2 and abs(yh - yt) == 1 ->
        {div(xh + xt, 2), yh}

      abs(xh - xt) == 1 and abs(yh - yt) == 2 ->
        {xh, div(yh + yt, 2)}

      abs(xh - xt) == 2 and abs(yh - yt) == 2 ->
        {div(xh + xt, 2), div(yh + yt, 2)}
    end
  end

  def propagate(_, []), do: []

  def propagate(xyh, [xyt | tail]) do
    next = tail_move(xyh, xyt)
    [next | propagate(next, tail)]
  end

  def head_move("R", log = [[{xh, yh} | tail] | _]),
    do: [[{xh + 1, yh} | propagate({xh + 1, yh}, tail)] | log]

  def head_move("U", log = [[{xh, yh} | tail] | _]),
    do: [[{xh, yh + 1} | propagate({xh, yh + 1}, tail)] | log]

  def head_move("L", log = [[{xh, yh} | tail] | _]),
    do: [[{xh - 1, yh} | propagate({xh - 1, yh}, tail)] | log]

  def head_move("D", log = [[{xh, yh} | tail] | _]),
    do: [[{xh, yh - 1} | propagate({xh, yh - 1}, tail)] | log]

  def solve(rope_length) do
    File.read!("inputs/22/i9.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [dir, amt] -> List.duplicate(dir, String.to_integer(amt)) end)
    |> List.flatten()
    |> Enum.reduce([for(_ <- 1..rope_length, do: {0, 0})], &head_move/2)
    |> Enum.map(&Enum.at(&1, -1))
    |> Enum.uniq()
    |> length()
  end

  def part1(), do: solve(2) |> IO.puts()
  def part2(), do: solve(10) |> IO.puts()
end

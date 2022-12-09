defmodule Aoc22.Day09 do
  # Not touching and different row and column, diagonal move
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
    end
  end

  def head_move("R", log = [{{xh, yh}, xyt} | _]),
    do: [{{xh + 1, yh}, tail_move({xh + 1, yh}, xyt)} | log]

  def head_move("U", log = [{{xh, yh}, xyt} | _]),
    do: [{{xh, yh + 1}, tail_move({xh, yh + 1}, xyt)} | log]

  def head_move("L", log = [{{xh, yh}, xyt} | _]),
    do: [{{xh - 1, yh}, tail_move({xh - 1, yh}, xyt)} | log]

  def head_move("D", log = [{{xh, yh}, xyt} | _]),
    do: [{{xh, yh - 1}, tail_move({xh, yh - 1}, xyt)} | log]

  def part1() do
    File.read!("inputs/22/t9.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&Regex.scan(~r/^\w|\d$/, &1))
    |> Enum.map(fn [[dir], [amt]] -> List.duplicate(dir, String.to_integer(amt)) end)
    |> List.flatten()
    |> Enum.reduce([{{0, 0}, {0, 0}}], &head_move/2)
    |> IO.inspect()

    # |> Enum.map(fn {_xyh, xyt} -> xyt end)
    # |> Enum.uniq()
    # |> length()
    # |> IO.puts()
  end
end

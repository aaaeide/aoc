defmodule Aoc22.Day10 do
  def prepare(["noop"]), do: :noop
  def prepare(["addx", amt]), do: [:adding, {:addx, String.to_integer(amt)}]

  def reducer({:addx, amt}, x), do: {x + amt, x + amt}
  def reducer(_, x), do: {x, x}

  def parse(path \\ "inputs/22/i10.txt") do
    File.read!(path)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(&prepare/1)
    |> List.flatten()
    |> Enum.map_reduce(1, &reducer/2)
    |> elem(0)
  end

  def part1(path \\ "inputs/22/i10.txt") do
    x_val = parse(path)

    [20, 60, 100, 140, 180, 220]
    |> Enum.map(&(Enum.at(x_val, &1 - 2) * &1))
    |> Enum.sum()
    |> IO.inspect()
  end

  def part2(path \\ "inputs/22/i10.txt") do
    ([1] ++ parse(path))
    |> Enum.reduce({'', 0}, fn x, {crt, px} ->
      if px in (x - 1)..(x + 1) do
        {crt ++ '██', (px + 1) |> rem(40)}
      else
        {crt ++ '  ', (px + 1) |> rem(40)}
      end
    end)
    |> elem(0)
    |> Enum.chunk_every(80)
    |> Enum.map(&List.to_string/1)
    |> IO.inspect()
  end
end

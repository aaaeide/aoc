defmodule Aoc21.Day02 do
  import Aoc21.Input, only: [readlines: 2]

  def pos_prod_1(instructions) do
    instructions
    |> Enum.reduce([0, 0], &pos_change_1(&1, &2))
    |> Enum.product()
  end

  def pos_change_1({"forward", amt}, [x, y]), do: [x + amt, y]
  def pos_change_1({"up", amt}, [x, y]), do: [x, y - amt]
  def pos_change_1({"down", amt}, [x, y]), do: [x, y + amt]

  def part1() do
    readlines("i2.txt", as: {:string, :integer})
    |> pos_prod_1()
    |> IO.puts()
  end

  def pos_prod_2(instructions) do
    instructions
    |> Enum.reduce([0, 0, 0], &pos_change_2(&1, &2))
    |> Enum.take(2)
    |> Enum.product()
  end

  def pos_change_2({"forward", amt}, [x, y, aim]), do: [x + amt, y + aim * amt, aim]
  def pos_change_2({"up", amt}, [x, y, aim]), do: [x, y, aim - amt]
  def pos_change_2({"down", amt}, [x, y, aim]), do: [x, y, aim + amt]

  def part2() do
    readlines("i2.txt", as: {:string, :integer})
    |> pos_prod_2()
    |> IO.puts()
  end
end

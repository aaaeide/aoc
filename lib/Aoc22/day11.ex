defmodule Aoc22.Day11 do
  import Enum, only: [map: 2, filter: 2, at: 2]

  def monkey_reducer(["Monkey", id], monkey),
    do: Map.put(monkey, :id, String.to_integer(id))

  def monkey_reducer(["Starting", "items" | items], monkey),
    do: Map.put(monkey, :items, map(items, &String.to_integer/1))

  def monkey_reducer(["Operation", "new", "=" | rest], monkey) do
    func =
      ("fn old -> " <> Enum.join(rest, " ") <> " end")
      |> Code.eval_string()
      |> elem(0)

    Map.put(monkey, :func, func)
  end

  def monkey_reducer(["Test", "divisible", "by", amt], monkey),
    do: Map.put(monkey, :test, String.to_integer(amt))

  def monkey_reducer(["If", "true" | rest], monkey),
    do: rest |> Enum.at(-1) |> String.to_integer() |> (&Map.put(monkey, :on_pass, &1)).()

  def monkey_reducer(["If", "false" | rest], monkey),
    do: rest |> Enum.at(-1) |> String.to_integer() |> (&Map.put(monkey, :on_fail, &1)).()

  def parse_monkeys(path \\ "inputs/22/i11.txt") do
    monkeys =
      File.read!(path)
      |> String.trim()
      |> String.split("\n\n")
      |> map(fn monkeystring ->
        monkeystring
        |> String.split("\n")
        |> map(&String.split(&1, [":", ",", " "], trim: true))
        |> Enum.reduce(%{activity: 0}, &monkey_reducer/2)
      end)

    prod = monkeys |> map(& &1[:test]) |> Enum.product()

    monkeys
    |> map(fn monkey ->
      Map.update!(monkey, :func, fn func -> fn old -> rem(func.(old), prod) end end)
    end)
  end

  def round(monkeys, 0, _), do: monkeys

  def round(monkeys, n, div_by) do
    0..(length(monkeys) - 1)
    |> Enum.reduce(monkeys, fn id, acc_monkeys ->
      thrower = acc_monkeys |> at(id)
      {self, on_pass, on_fail} = {thrower[:id], thrower[:on_pass], thrower[:on_fail]}

      items =
        thrower[:items]
        |> Enum.map(&thrower[:func].(&1))
        |> Enum.map(&div(&1, div_by))

      acc_monkeys
      |> Enum.map(fn monkey ->
        case monkey[:id] do
          ^self ->
            Map.update!(monkey, :items, fn _ -> [] end)
            |> Map.update!(:activity, &(&1 + length(items)))

          ^on_pass ->
            Map.update!(monkey, :items, fn stuff ->
              stuff ++ filter(items, &(rem(&1, thrower[:test]) == 0))
            end)

          ^on_fail ->
            Map.update!(monkey, :items, fn stuff ->
              stuff ++ filter(items, &(rem(&1, thrower[:test]) != 0))
            end)

          _ ->
            monkey
        end
      end)
    end)
    |> round(n - 1, div_by)
  end

  def calculate_monkey_business(monkeys) do
    monkeys |> Enum.map(& &1[:activity]) |> Enum.sort() |> Enum.slice(-2..-1) |> Enum.product()
  end

  def part1(), do: parse_monkeys() |> round(20, 3) |> calculate_monkey_business() |> IO.puts()
  def part2(), do: parse_monkeys() |> round(10000, 1) |> calculate_monkey_business() |> IO.puts()
end

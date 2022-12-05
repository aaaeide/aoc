defmodule Aoc22.Day05 do
  def parse_state(state) do
    state
    |> String.split("\n")
    |> Enum.slice(0..-2)
    |> Enum.map(fn l -> l |> String.to_charlist() |> tl() end)
    |> Enum.map(&Enum.take_every(&1, 4))
    |> Enum.map(&Enum.with_index/1)
    |> List.flatten()
    |> Enum.filter(fn {c, _} -> c != 32 end)
    |> Enum.reduce(%{}, fn {c, i}, map ->
      Map.update(map, i + 1, [c], &[c | &1])
    end)
    |> Enum.map(fn {i, lst} -> {i, Enum.reverse(lst)} end)
    |> Enum.into(%{})
  end

  def parse_proc(proc) do
    proc
    |> String.split("\n")
    |> Enum.map(&Regex.scan(~r/\d+/, &1))
    |> Enum.map(fn line ->
      line |> List.flatten() |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.filter(fn x -> x != [] end)
  end

  def parse(path \\ "inputs/22/i5.txt") do
    [state, proc] =
      File.read!(path)
      |> String.split("\n\n")

    {parse_state(state), parse_proc(proc)}
  end

  defp get_top({_, [top | _]}, out), do: [top | out]
  defp get_top({_, []}, out), do: out

  defp update(part) do
    fn [amt, frm, to], s ->
      {mov, rst} = Enum.split(s[frm], amt)
      mov = if part == 1, do: Enum.reverse(mov), else: mov

      %{s | frm => rst, to => [mov | s[to]] |> List.flatten()}
    end
  end

  def solve({state, proc}, part) do
    proc
    |> Enum.reduce(state, &update(part).(&1, &2))
    |> Enum.reduce('', &get_top/2)
    |> Enum.reverse()
  end

  def part1(), do: parse() |> solve(1) |> IO.puts()
  def part2(), do: parse() |> solve(2) |> IO.puts()
end

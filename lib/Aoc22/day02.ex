defmodule Aoc22.Day02 do
  @beats %{rock: :scissors, scissors: :paper, paper: :rock}
  @beaten_by %{rock: :paper, scissors: :rock, paper: :scissors}
  @scores %{rock: 1, paper: 2, scissors: 3}
  @shapes %{
    "A" => :rock,
    "X" => :rock,
    "B" => :paper,
    "Y" => :paper,
    "C" => :scissors,
    "Z" => :scissors
  }

  defp round_p1([cpu, you]) do
    cpu = @shapes[cpu]
    you = @shapes[you]

    case @beats do
      %{^you => ^cpu} -> 6 + @scores[you]
      %{^cpu => ^you} -> 0 + @scores[you]
      _ -> 3 + @scores[you]
    end
  end

  defp round_p2([cpu, "X"]), do: 0 + @scores[@beats[@shapes[cpu]]]
  defp round_p2([cpu, "Y"]), do: 3 + @scores[@shapes[cpu]]
  defp round_p2([cpu, "Z"]), do: 6 + @scores[@beaten_by[@shapes[cpu]]]

  def solve(round_fn) do
    File.read!("inputs/22/i2.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(&round_fn.(&1))
    |> Enum.sum()
    |> IO.puts()
  end

  def part1(), do: solve(&round_p1/1)
  def part2(), do: solve(&round_p2/1)
end

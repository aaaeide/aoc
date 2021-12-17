defmodule Aoc21.Day08 do
  import Aoc21.Input, only: [read_seven_seg_scramble: 1]
  import Enum, only: [at: 2]
  @num_segs [6, 2, 5, 5, 4, 5, 6, 3, 7, 6]

  def possible_matches(output) do
    for(
      digit <- output |> Enum.map(&String.graphemes/1),
      do: {
        digit,
        0..9 |> Enum.filter(fn i -> @num_segs |> at(i) == length(digit) end)
      }
    )
  end

  def do_part1(input) do
    input
    |> Enum.map(fn {_ptns, outs} ->
      outs
      |> possible_matches()
      |> Enum.count(fn {_digit, matches} -> length(matches) == 1 end)
    end)
    |> Enum.sum()
  end

  def part1() do
    read_seven_seg_scramble("i8.txt")
    |> do_part1()
    |> IO.puts()
  end
end

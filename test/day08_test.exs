defmodule Day08Test do
  use ExUnit.Case
  import Aoc21.Input, only: [read_seven_seg_scramble: 1]
  import Aoc21.Day08, only: [parse: 1]

  setup_all do
    [input: read_seven_seg_scramble("t8.txt")]
  end

  test "reads input properly", fixture do
    {[a, b, c | _], [x, y, z | _]} = hd(fixture.input)
    assert [a, b, c] == ["be", "cfbegad", "cbdgef"]
    assert [x, y, z] == ["fdgacbe", "cefdb", "cefbgd"]
  end

  test "parses output", fixture do
    fixture.input
    |> Enum.each(fn line ->
      line |> parse() |> IO.inspect()
    end)
  end
end

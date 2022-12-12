defmodule Aoc22.Day12Test do
  use ExUnit.Case
  import Aoc22.Day12, only: [parse: 1, find_S_E: 1]

  assert "finds S and E" do
    {grid, {s, e, g}} = parse("inputs/22/t12.txt") |> find_S_E()
    IO.inspect(grid)
    assert {s, e} == {{0, 0}, {5, 2}}
  end
end

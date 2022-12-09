defmodule Aoc22.Day08Test do
  alias Inspect.MapSet
  use ExUnit.Case
  import Aoc22.Day08, only: [solve: 2, num_visible: 2, scenic_score: 2]

  test "part 1" do
    assert solve(&num_visible/2, "inputs/22/t8.txt") == 21
  end

  test "part 2" do
    assert solve(&scenic_score/2, "inputs/22/t8.txt") == 8
  end
end

defmodule Day02Test do
  use ExUnit.Case

  import Aoc21.Input, only: [readlines: 2]
  import Aoc21.Day02, only: [pos_prod_1: 1, pos_prod_2: 1]

  setup_all do
    [
      instructions: readlines("t2.txt", as: {:string, :integer})
    ]
  end

  test "reads input properly", fixture do
    assert hd(fixture.instructions) == {"forward", 5}
  end

  test "part 1", fixture do
    assert fixture.instructions |> pos_prod_1 == 150
  end

  test "part 2", fixture do
    assert fixture.instructions |> pos_prod_2 == 900
  end
end

defmodule Day06Test do
  use ExUnit.Case
  import Aoc21.Input, only: [readlines: 3]
  import Aoc21.Day06, only: [n_days: 2]

  setup_all do
    [fish: readlines("t6.txt", ",", as: :integer)]
  end

  test "reads input properly", fixture do
    assert fixture.fish == [3, 4, 3, 1, 2]
  end

  test "updates fish stock one day at a time", fixture do
    assert fixture.fish |> n_days(1) |> MapSet.new() ==
             [2, 3, 2, 0, 1] |> MapSet.new()

    assert fixture.fish |> n_days(2) |> MapSet.new() ==
             [1, 2, 1, 6, 0, 8] |> MapSet.new()
  end

  # test "finds total stock after 256 days", fixture do
  #   assert fixture.fish |> n_days(256) |> length() == 26_984_457_539
  # end
end

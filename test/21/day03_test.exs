defmodule Day03Test do
  use ExUnit.Case

  import Aoc21.Input, only: [readlines: 2]

  import Aoc21.Day03,
    only: [
      bitlist_to_int: 1,
      gamma_rate_and_epsilon_rate: 1,
      oxygen_rating: 1,
      co2_rating: 1,
      most_common_bits: 1,
      flip_bits: 1
    ]

  setup_all do
    [bins: readlines("t3.txt", as: {:integer})]
  end

  test "reads input properly", fixture do
    assert hd(fixture.bins) == [0, 0, 1, 0, 0]
  end

  test "converts list of bits to integer" do
    assert bitlist_to_int([1, 0, 1, 1, 0]) == 22
  end

  test "most common bits", fixture do
    assert fixture.bins |> most_common_bits == [1, 0, 1, 1, 0]
  end

  test "flips bits" do
    assert [1, 0, 1, 1, 0] |> flip_bits == [0, 1, 0, 0, 1]
  end

  test "gamma rate and epsilon rate", fixture do
    assert fixture.bins |> gamma_rate_and_epsilon_rate == [22, 9]
  end

  test "oxygen rating", fixture do
    assert fixture.bins |> oxygen_rating == 23
  end

  test "co2 rating", fixture do
    assert fixture.bins |> co2_rating == 10
  end
end

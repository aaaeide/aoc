defmodule Day01Test do
  use ExUnit.Case
  doctest Aoc21.Day01

  import Aoc21.Day01,
    only: [
      count_depth_measurement_increase: 1,
      construct_sliding_window_sums: 1
    ]

  @depths "199
200
208
210
200
207
240
269
260
263
"

  @sliding_window_sums "607
618
618
617
647
716
769
792
"

  def read_integers(string) do
    string
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end

  test "count increases works on test input" do
    assert @depths
           |> read_integers()
           |> count_depth_measurement_increase() == 7
  end

  test "constructs sliding window sums correctly on test input" do
    assert @depths
           |> read_integers()
           |> construct_sliding_window_sums() ==
             read_integers(@sliding_window_sums)
  end
end

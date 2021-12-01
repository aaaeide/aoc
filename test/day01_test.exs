defmodule Day01Test do
  use ExUnit.Case

  import Aoc21.Day01,
    only: [
      count_depth_measurement_increase: 1,
      construct_sliding_window_sums: 1
    ]

  setup_all do
    [
      depths: [199, 200, 208, 210, 200, 207, 240, 269, 260, 263],
      sliding_window_sums: [607, 618, 618, 617, 647, 716, 769, 792]
    ]
  end

  test "count increases works on test input", fixture do
    assert fixture.depths
           |> count_depth_measurement_increase() == 7
  end

  test "constructs sliding window sums correctly on test input", fixture do
    assert fixture.depths
           |> construct_sliding_window_sums() ==
             fixture.sliding_window_sums
  end
end

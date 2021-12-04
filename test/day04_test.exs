defmodule Day04Test do
  use ExUnit.Case
  import Aoc21.Input, only: [readbingo: 1]

  import Aoc21.Day04,
    only: [
      play_bingo: 1,
      remove_elems: 2,
      cols: 1,
      find_worst_score: 1
    ]

  setup_all do
    [
      bingo: readbingo("t4.txt")
    ]
  end

  test "reads bingo", fixture do
    {numbers, boards} = fixture.bingo

    assert numbers |> Enum.take(3) == [7, 4, 9]
    assert boards |> hd() |> hd() == [22, 13, 17, 11, 0]
  end

  test "removes elements" do
    assert remove_elems([[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6]], [1, 3, 5]) ==
             [[nil, 2, nil, 4], [2, nil, 4, nil], [nil, 4, nil, 6]]
  end

  test "finds winning score", fixture do
    assert play_bingo(fixture.bingo) == 4512
  end

  test "finds worst score", fixture do
    assert find_worst_score(fixture.bingo) == 1924
  end

  test "finds cols", fixture do
    {_, [board | _]} = fixture.bingo
    assert board |> cols() |> hd() == [22, 8, 21, 6, 1]
  end
end

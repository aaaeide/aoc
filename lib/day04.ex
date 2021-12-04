defmodule Aoc21.Day04 do
  import Enum, only: [at: 2, map: 2, filter: 2, sum: 1]
  import Aoc21.Input, only: [readbingo: 1]

  @completed_line List.duplicate(nil, 5)

  def play_bingo({numbers, boards}) do
    {:ok, score, _, _} = next_number(numbers, [], boards)

    score
  end

  def find_worst_score(bingo) do
    play_all_boards(bingo)
    |> Enum.reverse()
    |> hd()
  end

  def play_all_boards({_numbers, []}), do: []

  def play_all_boards({numbers, boards}) do
    {:ok, score, rem_num, rem_boards} = next_number(numbers, [], boards)
    [score | play_all_boards({rem_num, rem_boards})]
  end

  defp next_number([num | rem_num], drawn, boards) do
    drawn = [num | drawn]

    with boardstates <- map(boards, &check_board(&1, drawn)),
         [{:win, score, _}] <-
           boardstates |> filter(fn {status, _, _} -> status == :win end),
         rem_boards <-
           boardstates
           |> filter(fn {status, _, _} -> status == :nowin end)
           |> map(fn {_, _, board} -> board end) do
      {:ok, score * num, rem_num, rem_boards}
    else
      _ -> next_number(rem_num, drawn, boards)
    end
  end

  defp check_board(board, drawn) do
    rows = board |> remove_elems(drawn)
    cols = board |> cols() |> remove_elems(drawn)

    if @completed_line in rows or @completed_line in cols,
      do: {:win, rows |> sum_board(), rows},
      else: {:nowin, -1, rows}
  end

  defp sum_board(board) do
    board |> List.flatten() |> filter(fn n -> n != nil end) |> sum()
  end

  def cols(board) do
    for i <- 0..4, do: for(row <- board, do: row |> at(i))
  end

  def remove_elems(list_of_lists, to_remove) do
    list_of_lists
    |> map(&map(&1, fn e -> if e in to_remove, do: nil, else: e end))
  end

  def part1() do
    readbingo("i4.txt")
    |> play_bingo()
    |> IO.puts()
  end

  def part2() do
    readbingo("i4.txt")
    |> play_all_boards()
    |> IO.puts()
  end
end

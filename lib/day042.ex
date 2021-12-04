defmodule Aoc21.Day042 do
  import Enum, only: [at: 2, map: 2, filter: 2]
  import Aoc21.Input, only: [readbingo: 1]

  def play_bingo({numbers, boards}) do
    {:ok, final_score, _board, _rem_boards, _rem_nums} =
      next_number(numbers, MapSet.new(), MapSet.new(boards))

    final_score
  end

  def play_bingo_poorly(bingo) do
    do_play_bingo_poorly(bingo)
    |> Enum.reverse()
    |> hd()
  end

  def do_play_bingo_poorly({_numbers, []}), do: []
  def do_play_bingo_poorly({[], _boards}), do: {:error, "should run out of boards before numbers"}

  def do_play_bingo_poorly({numbers, boards}) do
    {:ok, score, board, rem_boards, rem_nums} =
      next_number(numbers, MapSet.new(), MapSet.new(boards))

    [{score, board} | do_play_bingo_poorly({rem_nums, rem_boards})]
  end

  defp next_number([next | rest], drawnset, boardset) do
    drawnset = MapSet.put(drawnset, next)

    with boardstates <- boardset |> map(&check_board(&1, drawnset)),
         [{:win, board, rem_sum}] <-
           boardstates
           |> filter(fn {s, _, _} -> s == :win end),
         rem_boards <-
           boardstates
           |> filter(fn {s, _, _} -> s != :win end)
           |> map(fn {_, board, _} -> board end) do
      {:ok, {rem_sum, next}, board, rem_boards, rest}
    else
      _ -> next_number(rest, drawnset, boardset)
    end
  end

  defp next_number([], _, _), do: {:error, "out of numbers"}

  defp check_board(board, drawnset) do
    rows_rem = board |> remove_elems(drawnset)
    cols_rem = columns(board) |> remove_elems(drawnset)
    _diags_rem = diags(board) |> remove_elems(drawnset)

    # or [] in diags_rem
    if [] in rows_rem or [] in cols_rem,
      do: {:win, board, rows_rem |> List.flatten() |> Enum.sum()},
      else: {:nowin, rows_rem, 0}
  end

  defp remove_elems(lists, removeset) do
    lists
    |> map(&MapSet.new(&1))
    |> map(&MapSet.difference(&1, removeset))
    |> map(&MapSet.to_list(&1))
  end

  def columns(board) do
    for i <- 0..4,
        do: for(row <- board, do: row |> at(i))
  end

  def diags(board) do
    [
      for(i <- 0..4, do: board |> at(i) |> at(i)),
      for(i <- 0..4, do: board |> at(4 - i) |> at(i))
    ]
  end

  def part1() do
    readbingo("i4.txt")
    |> play_bingo()
    |> IO.puts()
  end
end

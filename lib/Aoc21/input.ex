defmodule Aoc21.Input do
  @inputsfolder "inputs/21"

  defp do_readlines(filename, delim \\ "\n") do
    File.read!("#{@inputsfolder}/#{filename}")
    |> String.trim()
    |> String.split(delim, trim: true)
  end

  # Day 1, 6, 7
  def readlines(filename, delim \\ "\n", as)

  def readlines(filename, delim, as: :integer) do
    do_readlines(filename, delim)
    |> Enum.map(&String.to_integer(&1))
  end

  # Day 2
  def readlines(filename, _, as: {:string, :integer}) do
    do_readlines(filename)
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [str, int] -> {str, String.to_integer(int)} end)
  end

  # Day 3
  def readlines(filename, _, as: {:integer}) do
    do_readlines(filename)
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer(&1))
    end)
  end

  # Day 9, 11
  def readlines(filename, _, as: [:integer]) do
    do_readlines(filename)
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
    end)
  end

  # Day 10
  def readlines(filename, _, as: [:charlist]) do
    do_readlines(filename)
    |> Enum.map(&String.to_charlist/1)
  end

  # Day 4
  def readbingo(filename) do
    [numbers | boards] = do_readlines(filename, "\n\n")

    {
      numbers |> String.split(",") |> Enum.map(&String.to_integer(&1)),
      boards
      |> Enum.map(fn board ->
        String.split(board, "\n", trim: true)
        |> Enum.map(fn line ->
          String.split(line, ~r/\s+/, trim: true)
          |> Enum.map(&String.to_integer(&1))
        end)
      end)
    }
  end

  # Day 5
  def read_line_segments(filename) do
    do_readlines(filename)
    |> Enum.map(&String.split(&1, " -> "))
    |> Enum.map(fn [fromstr, tostr] ->
      {
        String.split(fromstr, ",") |> Enum.map(&String.to_integer/1) |> List.to_tuple(),
        String.split(tostr, ",") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
      }
    end)
  end

  # Day 8
  def read_seven_seg_scramble(filename) do
    do_readlines(filename)
    |> Enum.map(&String.split(&1, " | "))
    |> Enum.map(fn [patterns, output] ->
      {patterns |> String.split(" "), output |> String.split(" ")}
    end)
  end
end

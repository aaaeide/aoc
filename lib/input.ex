defmodule Aoc21.Input do
  @inputsfolder "inputs"

  defp do_readlines(filename, delim \\ "\n") do
    File.read!("#{@inputsfolder}/#{filename}")
    |> String.split(delim, trim: true)
  end

  # Day 1
  def readlines(filename, as: :integer) do
    do_readlines(filename)
    |> Enum.map(&String.to_integer(&1))
  end

  # Day 2
  def readlines(filename, as: {:string, :integer}) do
    do_readlines(filename)
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [str, int] -> {str, String.to_integer(int)} end)
  end

  # Day 3
  def readlines(filename, as: {:integer}) do
    do_readlines(filename)
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer(&1))
    end)
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
end

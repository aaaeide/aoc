defmodule Aoc21.Input do
  @inputsfolder "inputs"

  def readlines(filename) do
    File.read!("#{@inputsfolder}/#{filename}")
    |> String.split("\n", trim: true)
  end

  # Day 1
  def readlines(filename, as: :integer) do
    readlines(filename)
    |> Enum.map(&String.to_integer(&1))
  end

  # Day 2
  def readlines(filename, as: {:string, :integer}) do
    readlines(filename)
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [str, int] -> {str, String.to_integer(int)} end)
  end

  # Day 3
  def readlines(filename, as: {:integer}) do
    readlines(filename)
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer(&1))
    end)
  end
end

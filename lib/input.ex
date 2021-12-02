defmodule Aoc21.Input do
  @inputsfolder "inputs"

  def readlines(filename) do
    File.read!("#{@inputsfolder}/#{filename}")
    |> String.split("\n", trim: true)
  end

  def readlines(filename, as: :integer) do
    readlines(filename)
    |> Enum.map(&String.to_integer(&1))
  end

  def readlines(filename, as: {:string, :integer}) do
    readlines(filename)
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [str, int] -> {str, String.to_integer(int)} end)
  end
end

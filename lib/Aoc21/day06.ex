defmodule Aoc21.Day06 do
  import Aoc21.Input, only: [readlines: 3]
  def n_days(fish, 0), do: fish

  def n_days(fish, n) do
    fish
    |> Enum.reduce([], &update_fish_list(&1, &2))
    |> n_days(n - 1)
  end

  def update_fish_list(0, list), do: [8, 6 | list]
  def update_fish_list(fish, list), do: [fish - 1 | list]

  # part 1: 80, part 2: 256
  def solve_for(n) do
    readlines("i6.txt", ",", as: :integer)
    |> n_days(n)
    |> length()
    |> IO.puts()
  end
end

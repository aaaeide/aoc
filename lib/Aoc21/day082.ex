defmodule Aoc21.Day082 do
  def permute([]), do: [[]]
  def permute(list), do: for(elem <- list, rest <- permute(list -- [elem]), do: [elem | rest])
end

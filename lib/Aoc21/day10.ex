defmodule Aoc21.Day10 do
  import Aoc21.Input, only: [readlines: 2]

  @spec validate_line(charlist, charlist) :: {:ok, charlist} | {:error, char}
  # base case
  defp validate_line('', stack), do: {:ok, stack}
  # pop from stack
  defp validate_line([?) | r1], [?( | r2]), do: validate_line(r1, r2)
  defp validate_line([?] | r1], [?[ | r2]), do: validate_line(r1, r2)
  defp validate_line([?} | r1], [?{ | r2]), do: validate_line(r1, r2)
  defp validate_line([?> | r1], [?< | r2]), do: validate_line(r1, r2)
  # push to stack
  defp validate_line([?( | r1], stack), do: validate_line(r1, '(' ++ stack)
  defp validate_line([?[ | r1], stack), do: validate_line(r1, '[' ++ stack)
  defp validate_line([?{ | r1], stack), do: validate_line(r1, '{' ++ stack)
  defp validate_line([?< | r1], stack), do: validate_line(r1, '<' ++ stack)
  # fail
  defp validate_line([invalid | _r1], _stack), do: {:error, invalid}

  defp line_score({:ok, _}), do: 0
  defp line_score({:error, ?)}), do: 3
  defp line_score({:error, ?]}), do: 57
  defp line_score({:error, ?}}), do: 1197
  defp line_score({:error, ?>}), do: 25137

  @spec syntax_error_score([charlist]) :: non_neg_integer
  def syntax_error_score([]), do: 0

  def syntax_error_score([line | rest]) do
    (line |> validate_line('') |> line_score()) + syntax_error_score(rest)
  end

  @pts %{?( => 1, ?[ => 2, ?{ => 3, ?< => 4}

  @spec autocomplete_score(charlist, integer) :: non_neg_integer
  def autocomplete_score([], score), do: score

  def autocomplete_score([head | rest], score),
    do: autocomplete_score(rest, 5 * score + Map.get(@pts, head))

  def part1() do
    readlines("i10.txt", as: [:charlist])
    |> syntax_error_score()
    |> IO.puts()
  end

  def part2() do
    readlines("i10.txt", as: [:charlist])
    |> Enum.map(&validate_line(&1, ''))
    |> Enum.filter(fn {status, _} -> status == :ok end)
    |> Enum.map(fn {:ok, stack} -> autocomplete_score(stack, 0) end)
    |> Enum.sort()
    |> (&Enum.at(&1, (length(&1) / 2) |> floor)).()
    |> IO.puts()
  end
end

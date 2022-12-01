defmodule Aoc21.Day03 do
  import Aoc21.Input, only: [readlines: 2]

  def bitlist_to_int(bitlist) do
    bitlist
    |> List.foldr({0, 0}, fn bit, {cur, pow} ->
      {(cur + bit * :math.pow(2, pow)) |> round, pow + 1}
    end)
    |> elem(0)
  end

  def most_common_bits([first | bins]) do
    {sum_list, num_bins} =
      bins
      |> Enum.reduce({first, 1}, fn bin, {acc, cnt} ->
        {[bin, acc] |> Enum.zip_with(fn [x, y] -> x + y end), cnt + 1}
      end)

    sum_list |> Enum.map(&set_mcb(&1, num_bins))
  end

  defp set_mcb(sum, num) when sum > num / 2, do: 1
  defp set_mcb(sum, num) when sum < num / 2, do: 0
  # ambiguity only appears in p2
  defp set_mcb(sum, num) when sum == num / 2, do: 0.5

  def least_common_bits(bins), do: bins |> most_common_bits |> flip_bits
  def flip_bits(bits), do: bits |> Enum.map(&flip(&1))
  defp flip(0), do: 1
  defp flip(0.5), do: 0.5
  defp flip(1), do: 0

  def gamma_rate_and_epsilon_rate(bins) do
    mcb = most_common_bits(bins)

    [
      mcb |> bitlist_to_int,
      mcb |> flip_bits |> bitlist_to_int
    ]
  end

  def rating([last], _, _, _), do: last

  def rating(bins, target_bit_selector, ambig_fallback, idx) do
    remove_ambiguity = fn b -> if b == 0.5, do: ambig_fallback, else: b end
    target = target_bit_selector.(bins) |> Enum.at(idx) |> remove_ambiguity.()

    bins
    |> Enum.filter(fn bits ->
      bits
      |> Enum.at(idx)
      |> remove_ambiguity.() == target
    end)
    |> rating(target_bit_selector, ambig_fallback, idx + 1)
  end

  def oxygen_rating(bins), do: rating(bins, &most_common_bits(&1), 1, 0) |> bitlist_to_int()
  def co2_rating(bins), do: rating(bins, &least_common_bits(&1), 0, 0) |> bitlist_to_int()

  def part1() do
    readlines("i3.txt", as: {:integer})
    |> gamma_rate_and_epsilon_rate()
    |> Enum.product()
    |> IO.puts()
  end

  def part2() do
    readlines("i3.txt", as: {:integer})
    |> (&(oxygen_rating(&1) * co2_rating(&1))).()
    |> IO.puts()
  end
end

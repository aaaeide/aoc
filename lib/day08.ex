defmodule Aoc21.Day08 do
  import Aoc21.Input, only: [read_seven_seg_scramble: 1]
  import Enum, only: [at: 2]
  import MapSet, only: [size: 1, intersection: 2, union: 2]

  @canonical_segs [
    MapSet.new([:a, :b, :c, :e, :f, :g]),
    MapSet.new([:c, :f]),
    MapSet.new([:a, :c, :d, :e, :g]),
    MapSet.new([:a, :c, :d, :f, :g]),
    MapSet.new([:b, :c, :d, :f]),
    MapSet.new([:a, :b, :d, :f, :g]),
    MapSet.new([:a, :b, :d, :e, :f, :g]),
    MapSet.new([:a, :c, :f]),
    MapSet.new([:a, :b, :c, :d, :e, :f, :g]),
    MapSet.new([:a, :b, :c, :d, :f, :g])
  ]

  def map_to_nums(ptns) do
    # To begin with, all signal wires can map to all segments
    initial_mappings =
      for wire <- String.graphemes("abcdefg"),
          into: %{},
          do: {wire, MapSet.new([:a, :b, :c, :d, :e, :f, :g])}

    # Find all possible segments for each signal wire
    ptns
    |> Enum.reduce(initial_mappings, fn ptn, mappings ->
      possible_matches =
        @canonical_segs
        |> Enum.filter(fn digit -> size(digit) == String.length(ptn) end)
        |> Enum.reduce(fn set, acc -> union(set, acc) end)

      ptn
      |> String.graphemes()
      |> Enum.reduce(mappings, fn wire, map ->
        Map.update!(map, wire, fn old_mappings ->
          intersection(old_mappings, possible_matches)
        end)
      end)
    end)
    |> assign_segs(ptns)
  end

  def assign_segs(possible_seg_mapping, ptns) do
    possible_seg_mapping
    # Sort in ascending order of number of possible segments
    |> Map.to_list()
    |> Enum.sort(fn {_k1, val1}, {_k2, val2} -> val1 <= val2 end)
    |> do_assign_seg(%{}, ptns)
  end

  def do_assign_seg([], mapped, ptns) do
    transl = construct_translation(ptns, mapped)

    if "x" in Map.values(transl) do
      raise "INVALID MAPPING"
    end

    transl
  end

  def do_assign_seg([{wire, %MapSet{map: map}} | _rest], _mapped, _ptns)
      when map_size(map) == 0,
      do: raise("NO POSSIBLE SEGMENTS FOR #{wire}!")

  def do_assign_seg([{wire, possible_segs} | rest], mapped, ptns) do
    # get next segment to try to match to wire
    {selected_seg, remaining_lst} = possible_segs |> MapSet.to_list() |> List.pop_at(0)

    try do
      do_assign_seg(
        # remove segment from other wires' possible_segs
        rest |> Enum.map(fn {w, segs} -> {w, MapSet.delete(segs, selected_seg)} end),
        # add segment to tentative mapping
        mapped |> Map.put(wire, selected_seg),
        ptns
      )
    rescue
      # if error is raised, drop seg from this wire's possible_segs and retry this wire
      RuntimeError -> do_assign_seg([{wire, MapSet.new(remaining_lst)} | rest], mapped, ptns)
    end
  end

  def construct_translation(ptns, seg_map) do
    ptns
    |> Enum.map(fn ptn -> ptn |> String.to_charlist() |> Enum.sort() end)
    |> Enum.map(fn wires ->
      {wires |> List.to_string(),
       0..9
       |> Enum.find("x", fn i ->
         @canonical_segs |> at(i) ==
           wires |> Enum.map(fn wire -> Map.get(seg_map, wire) end) |> MapSet.new()
       end)}
    end)
    |> (&for({ptn, num} <- &1, into: %{}, do: {ptn, num})).()
  end

  def parse({ptns, out}) do
    transl = map_to_nums(ptns)

    out
    |> Enum.map(fn out_ptn ->
      out_ptn |> String.to_charlist() |> Enum.sort() |> List.to_string()
    end)
    |> Enum.map(fn out_ptn -> Map.get(transl, out_ptn) end)
  end

  def part1() do
  end
end

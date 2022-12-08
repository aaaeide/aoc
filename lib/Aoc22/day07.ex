defmodule Aoc22.Day07 do
  def build_tree_from_input(path \\ "inputs/22/i7.txt") do
    # %{x => {up, down, files=[{size, name}], size}}

    File.read!(path)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split/1)
    |> Enum.reduce({nil, []}, &build_tree/2)

    # |> elem(0)
  end

  # Initialize.
  def build_tree(["$", "cd", "/"], {_tree, _dir}),
    do: {%{["/"] => %{up: nil, down: [], files: [], size: 0}}, ["/"]}

  def build_tree(["$", "cd", ".."], {tree, dir}) do
    up = tree[dir][:up]

    {
      Map.update!(tree, up, fn map -> %{map | size: map[:size] + tree[dir][:size]} end),
      dir |> Enum.slice(0..-2)
    }
  end

  def build_tree(["$", "cd", x], {tree, dir}), do: {tree, dir ++ [x]}

  def build_tree(["$", "ls"], {tree, dir}), do: {tree, dir}

  def build_tree(["dir", x], {tree, dir}) do
    if Map.has_key?(tree, x) do
      IO.puts("dir #{x} already in tree")
    end

    {
      tree
      |> Map.update!(dir, &%{&1 | down: [dir ++ [x] | &1[:down]]})
      |> Map.put(dir ++ [x], %{up: dir, down: [], files: [], size: 0}),
      dir
    }
  end

  def build_tree([size, name], {tree, dir}) do
    size = String.to_integer(size)

    {
      Map.update!(tree, dir, &%{&1 | files: [{size, name} | &1[:files]], size: &1[:size] + size}),
      dir
    }
  end

  def do_part1(path \\ "inputs/22/i7.txt") do
    path
    |> build_tree_from_input()
    |> Enum.filter(fn {_, v} -> v[:size] <= 100_000 end)
    |> Enum.map(fn {_, v} -> v[:size] end)
    |> Enum.sum()
  end

  def part1(), do: do_part1() |> IO.puts()

  def part2() do
    tree = build_tree_from_input()
    remaining = 70_000_000 - tree[["/"]][:size]
    needed = 30_000_000 - remaining

    tree
    |> Enum.map(fn {dir, map} -> {dir, map[:size]} end)
    |> Enum.sort(&(&1 >= &2))
    |> Enum.filter(fn {_, v} -> v >= needed end)
    |> hd()
    |> elem(1)
    |> IO.puts()
  end
end

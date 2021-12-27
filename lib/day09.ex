defmodule Aoc21.Day09 do
  import Aoc21.Input, only: [readlines: 2]

  defp at(matrix, x, y), do: matrix |> Enum.at(y) |> Enum.at(x)

  def find_lowpoints(heightmap) do
    0..(length(heightmap) - 1)
    |> Enum.reduce([], fn y, points ->
      0..(length(heightmap |> Enum.at(y)) - 1)
      |> Enum.reduce(points, fn x, pts ->
        min_neigh =
          get_neighbors(heightmap, x, y)
          |> Enum.map(fn {x, y} -> heightmap |> at(x, y) end)
          |> Enum.min()

        pt = heightmap |> at(x, y)

        if pt < min_neigh do
          pts ++ [{pt, x, y}]
        else
          pts
        end
      end)
    end)
  end

  @spec get_neighbors(list(list(integer)), integer, integer) :: [integer]
  defp get_neighbors(hm, x, y) do
    [
      upneighbor(hm, x, y),
      leftneighb(hm, x, y),
      rightneigh(hm, x, y),
      downneighb(hm, x, y)
    ]
    |> Enum.filter(fn n -> n != nil end)
  end

  defp upneighbor(_hm, _x, 0), do: nil
  defp upneighbor(_hm, x, y), do: {x, y - 1}

  defp leftneighb(_hm, 0, _y), do: nil
  defp leftneighb(_hm, x, y), do: {x - 1, y}

  defp rightneigh(hm, x, _y) when x == length(hd(hm)) - 1, do: nil
  defp rightneigh(_hm, x, y), do: {x + 1, y}

  defp downneighb(hm, _x, y) when y == length(hm) - 1, do: nil
  defp downneighb(_hm, x, y), do: {x, y + 1}

  def find_lowpoint_score(heightmap) do
    heightmap
    |> find_lowpoints()
    |> Enum.reduce(0, fn {pt, _x, _y}, acc -> acc + pt + 1 end)
  end

  def find_basins(heightmap) do
    # assumes each basin has exactly one lowpoint
    heightmap
    |> find_lowpoints()
    |> Enum.reduce([], fn {_pt, x, y}, basins ->
      basins ++ [explore_basin(heightmap, [], [{x, y}])]
    end)
  end

  def explore_basin(_hm, pts, []), do: pts

  def explore_basin(hm, points, _to_explore = [{x, y} | rest]) do
    # Recursive BFS
    if hm |> at(x, y) < 9 and {x, y} not in points do
      explore_basin(hm, points ++ [{x, y}], rest ++ get_neighbors(hm, x, y))
    else
      explore_basin(hm, points, rest)
    end
  end

  def prettyprint_basins(basins, heightmap) do
    to_print = basins |> List.flatten()

    0..(length(heightmap) - 1)
    |> Enum.reduce(["\n"], fn i, rows ->
      rows ++
        [
          0..(length(heightmap |> Enum.at(i)) - 1)
          |> Enum.reduce('', fn j, chlst ->
            chlst ++
              if {j, i} in to_print do
                heightmap |> at(j, i) |> Integer.to_charlist()
              else
                '_'
              end
          end)
          |> List.to_string()
        ]
    end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  def do_part2(heightmap) do
    find_basins(heightmap)
    |> Enum.map(&length/1)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.product()
  end

  def part1() do
    readlines("i9.txt", as: [:integer])
    |> find_lowpoint_score()
    |> IO.puts()
  end

  def part2() do
    readlines("i9.txt", as: [:integer])
    |> do_part2()
    |> IO.puts()
  end
end

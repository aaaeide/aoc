defmodule Aoc22.Day07Test do
  use ExUnit.Case
  import Aoc22.Day07, only: [build_tree_from_input: 1, do_part1: 1]

  test "leaf size" do
    tree = build_tree_from_input("inputs/22/t7.txt")
    assert tree["e"] == %{up: "a", down: [], files: [{584, "i"}], size: 584}
  end

  test "inner node sies" do
    tree = build_tree_from_input("inputs/22/t7.txt")

    assert tree["a"] == %{
             up: "/",
             down: ["e"],
             files: [{62596, "h.lst"}, {2557, "g"}, {29116, "f"}],
             size: 94853
           }

    assert tree["d"] == %{
             up: "/",
             down: [],
             files: [
               {7_214_296, "k"},
               {5_626_152, "d.ext"},
               {8_033_020, "d.log"},
               {4_060_174, "j"}
             ],
             size: 24_933_642
           }

    assert tree["/"] == %{
             up: nil,
             down: ["d", "a"],
             files: [{8_504_156, "c.dat"}, {14_848_514, "b.txt"}],
             size: 48_381_165
           }
  end

  test "part 1" do
    assert do_part1("inputs/22/t7.txt") == 95437
  end
end

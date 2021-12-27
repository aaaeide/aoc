defmodule Day10Test do
  use ExUnit.Case
  import Aoc21.Input, only: [readlines: 2]
  import Aoc21.Day10, only: [syntax_error_score: 1, autocomplete_score: 2]

  setup_all do
    [code: readlines("t10.txt", as: [:charlist])]
  end

  test "reads input properly", fixture do
    assert hd(fixture.code) == '[({(<(())[]>[[{[]{<()<>>'
  end

  test "finds syntax error score", fixture do
    assert fixture.code |> syntax_error_score == 26397
  end

  test "finds autocomplete score" do
    assert '}}]])})]' |> autocomplete_score(0) == 288_957
  end
end

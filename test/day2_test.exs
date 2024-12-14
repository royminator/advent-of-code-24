defmodule AdventOfCode24.Day2.Tests do
  use ExUnit.Case
  import AdventOfCode24.Day2

  test "problem dampener should be safe" do
    assert problem_dampened([1, 2, 3, 4, 12])
  end

  test "problem dampener should be unsafe" do
    assert !problem_dampened([1, 112, 3, 4, 12])
  end

  test "part 2" do
    reports = [
      [1, 2, 3, 4, 5],
      [1, 5, 6, 7, 8],
      [1, 2, 4, -3, -8]]

    assert part2(reports) == 2
  end
end

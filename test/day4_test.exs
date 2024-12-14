defmodule AdventOfCode24.Day4.Tests do
  use ExUnit.Case
  import AdventOfCode24.Day4

  def example_input(), do:
    ["MMMSXXMASM",
     "MSAMXMSMSA",
     "AMXSXMAAMM",
     "MSAMASMSMX",
     "XMASAMXAMM",
     "XXAMMXXAMA",
     "SMSMSASXSS",
     "SAXAMASAAA",
     "MAMMMXMMMM",
     "MXMXAXMASX"]
    |> Enum.map(&String.graphemes/1)

  test "example part 1" do
    assert 18 == example_input() |> part1()
  end

  test "fwd" do
    assert fwd(example_input(), 0, 5, 10, 10)
    assert !fwd(example_input(), 0, 4, 10, 10)
  end

  test "fwd when out of bounds" do
    assert !fwd(example_input(), 0, 6, 10, 10)
  end

  test "bwd" do
    assert bwd(example_input(), 1, 4, 10, 10)
  end

  test "bwd when out of bounds" do
    assert !bwd(example_input(), 1, 3, 10, 10)
  end

  test "down" do
    assert down(example_input(), 3, 9, 10, 10)
  end

  test "down when out of bounds" do
    assert !down(example_input(), 7, 3, 10, 10)
  end

  test "up" do
    assert up(example_input(), 4, 6, 10 ,10)
  end

  test "up when out of bounds" do
    assert !up(example_input(), 2, 6, 10 ,10)
  end

  test "diag_se" do
    assert diag_se(example_input(), 0, 4, 10, 10)
  end

  test "diag_sw" do
    assert diag_sw(example_input(), 3, 9, 10, 10)
  end

  test "diag_ne" do
    assert diag_ne(example_input(), 5, 0, 10, 10)
  end

  test "diag_nw" do
    assert diag_nw(example_input(), 5, 6, 10, 10)
    assert diag_nw(example_input(), 9, 9, 10, 10)
    assert diag_nw(example_input(), 9, 3, 10, 10)
  end
end

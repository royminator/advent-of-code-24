defmodule AdventOfCode24.Day4 do
  import AdventOfCode24.Common
  def main() do
    read_and_parse_input("res/input/day4.txt", &String.split(&1, "\r\n"))
    |> Enum.map(&String.graphemes/1)
    |> part1()
  end

  def part1(matrix) do
    traverse(matrix)
  end

  def traverse(matrix) do
    cols = Enum.count(Enum.at(matrix, 0))
    rows = Enum.count(matrix)
    Enum.map(0..rows-1, fn m ->
      Enum.map(0..cols-1, fn n ->
        count_matches(matrix, m, n, rows, cols)
      end)
    end)
    |> Enum.concat()
    |> Enum.sum()
  end

  def count_matches(matrix, m, n, rows, cols) do
    [{:fwd, fwd(matrix, m, n, rows, cols)},
    {:bwd, bwd(matrix, m, n, rows, cols)},
    {:up, up(matrix, m, n, rows, cols)},
    {:down, down(matrix, m, n, rows, cols)},
    {:ne, diag_ne(matrix, m, n, rows, cols)},
    {:nw, diag_nw(matrix, m, n, rows, cols)},
    {:se, diag_se(matrix, m, n, rows, cols)},
    {:sw, diag_sw(matrix, m, n, rows, cols)}]
    |> Enum.filter(fn {_, x} -> x end)
    |> Enum.count()
  end

  def fwd(mat, m, n, _, cols) when n < cols - 3, do:
    Enum.slice(Enum.at(mat, m), n, 4) == ["X", "M", "A", "S"]
  def fwd(_, _, _, _, _), do: false

  def bwd(mat, m, n, _, _) when n > 2, do:
    Enum.slice(Enum.at(mat, m), n-3, 4) == Enum.reverse(["X", "M", "A", "S"])
  def bwd(_, _, _, _, _), do: false

  def down(mat, m, n, rows, _) when m < rows - 3 do
    Enum.map(0..3, fn x -> Enum.at(Enum.at(mat, m+x), n) end)
    == ["X", "M", "A", "S"]
  end
  def down(_, _, _, _, _), do: false

  def up(mat, m, n, _, _) when m > 2 do
    Enum.map(0..3, fn x -> Enum.at(Enum.at(mat, m-x), n) end)
    == ["X", "M", "A", "S"]
  end
  def up(_, _, _, _, _), do: false

  def diag_se(mat, m, n, rows, cols) when m < rows - 3 and n < cols - 3 do
    Enum.map(0..3, fn x -> Enum.at(Enum.at(mat, m+x), n+x) end)
    == ["X", "M", "A", "S"]
  end
  def diag_se(_, _, _, _, _), do: false

  def diag_sw(mat, m, n, rows, _) when m < rows - 3 and n > 2 do
    Enum.map(0..3, fn x -> Enum.at(Enum.at(mat, m+x), n-x) end)
    == ["X", "M", "A", "S"]
  end
  def diag_sw(_, _, _, _, _), do: false

  def diag_nw(mat, m, n, _, _) when m > 2 and n > 2 do
    Enum.map(0..3, fn x -> Enum.at(Enum.at(mat, m-x), n-x) end)
    == ["X", "M", "A", "S"]
  end
  def diag_nw(_, _, _, _, _), do: false

  def diag_ne(mat, m, n, _, cols) when m > 2 and n < cols - 3 do
    Enum.map(0..3, fn x -> Enum.at(Enum.at(mat, m-x), n+x) end)
    == ["X", "M", "A", "S"]
  end
  def diag_ne(_, _, _, _, _), do: false
end

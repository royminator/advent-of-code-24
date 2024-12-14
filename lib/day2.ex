defmodule AdventOfCode24.Day2 do
  import AdventOfCode24.Common

  defmodule ReportSafety do
    defstruct prev: 0,
              dir: :undefined,
              is_initial: true,
              is_safe: true,
              report: []
  end

  def main do
    input = read_and_parse_input("res/input/day2.txt", &parse_input/1)
    {input |> part1, input |> part2}
  end

  def parse_input(content) do
    String.split(content, "\r\n", trim: true)
    |> Enum.map(&line_to_list_of_ints/1)
  end

  def part1(reports) do
    reports
    |> Enum.map(&is_safe/1)
    |> Enum.filter(fn safety -> safety.is_safe end)
    |> Enum.count()
  end

  def part2(reports) do
    n_safe = part1(reports)

    n_safe + (
      reports
      |> Enum.map(&is_safe/1)
      |> Enum.filter(fn safety -> !safety.is_safe end)
      |> Enum.map(fn s -> s.report end)
      |> Enum.map(&problem_dampened/1)
      |> Enum.filter(fn x -> x end)
      |> Enum.count()
    )
  end

  def problem_dampened(failing) do
    failing
    |> Enum.with_index()
    |> Enum.map(fn {_, i} ->
      is_safe(List.delete_at(failing, i))
    end)
    |> Enum.filter(fn s -> s.is_safe end)
    |> Enum.count() > 0
  end

  def is_safe(report) do
    Enum.reduce(report, %ReportSafety{report: report}, &process_next/2)
  end

  def process_next(val, acc) do
    case acc.is_initial do
      true -> %{acc | prev: val, is_initial: false}
      false -> is_report_still_safe(val, acc)
    end
  end

  def is_report_still_safe(val, acc) do
    diff = acc.prev - val
    dir = get_dir(diff)
    case dir == :undefined || direction_was_swapped(acc.dir, dir) do
      true -> %{acc | prev: val, dir: dir, is_safe: false}
      false ->
        case is_valid_diff(diff, dir) do
          true -> %{acc | prev: val, dir: dir}
          false -> %{acc | prev: val, dir: dir, is_safe: false}
        end
    end
  end

  def direction_was_swapped(prev_dir, curr_dir) do
    prev_dir != :undefined && prev_dir != curr_dir
  end

  def get_dir(diff) when diff < 0, do: :increasing
  def get_dir(diff) when diff > 0, do: :decreasing
  def get_dir(diff) when diff == 0, do: :undefined

  def is_valid_diff(diff, :decreasing), do: diff <= 3 && diff > 0
  def is_valid_diff(diff, :increasing), do: diff < 0 && diff >= -3
  def is_valid_diff(_: :undefined), do: false
end

defmodule AdventOfCode24.Day2 do
  import AdventOfCode24.Common

  defmodule ReportSafety do
    defstruct prev: 0,
              dir: :undefined,
              is_initial: true,
              is_safe: false
  end

  def main do
    input = read_and_parse_input("res/input/day2.txt", &parse_input/1)
    {input |> check_reports}
  end

  def parse_input(content) do
    String.split(content, "\r\n", trim: true)
    |> Enum.map(&line_to_list_of_ints/1)
  end

  def check_reports(reports) do
    Enum.reduce(reports, 0, &count_safe_reports/2)
  end

  def count_safe_reports(report, acc) do
    case is_safe(report) do
      true -> acc + 1
      _ -> acc
    end
  end

  def is_safe(report) do
    safety = Enum.reduce_while(report, %ReportSafety{}, &process_next/2)
    safety.is_safe
  end

  def process_next(val, acc) do
    case acc.is_initial do
      true -> {:cont, %ReportSafety{prev: val, dir: :undefined, is_safe: true, is_initial: false}}
      _ -> is_report_still_safe(val, acc)
    end
  end

  def is_report_still_safe(val, acc) do
    diff = acc.prev - val
    dir = get_dir(diff)
    case dir == :undefined || direction_was_swapped(acc.dir, dir) do
      true -> {:halt, %ReportSafety{is_safe: false}}
      false ->
        case is_valid_diff(diff, dir) do
          true -> {:cont, %ReportSafety{prev: val, dir: dir, is_safe: true, is_initial: false}}
          false -> {:halt, %ReportSafety{is_safe: false, is_initial: false}}
        end
    end
  end

  def direction_was_swapped(prev_dir, curr_dir) do
    prev_dir != :undefined && prev_dir != curr_dir
  end

  def get_dir(diff) when diff < 0, do: :increasing
  def get_dir(diff) when diff > 0, do: :decreasing
  def get_dir(diff) when diff == 0, do: :undefined

  def is_valid_diff(diff, :decreasing) do
    diff <= 3 && diff > 0
  end

  def is_valid_diff(diff, :increasing) do
    diff < 0 && diff >= -3
  end

  def is_valid_diff(_diff: :undefined), do: false
end

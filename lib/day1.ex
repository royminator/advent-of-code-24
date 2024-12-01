defmodule AdventOfCode24.Day1 do
  def main do
    read_input_to_lists("res/input/day1.txt")
    |> calculate_distance()
    |> Enum.sum()
  end

  def read_input_to_lists(path) do
    case File.read(path) do
      {:ok, content} -> parse_input(content)
      {:error, reason} -> IO.puts("failed to read the file: #{reason}")
    end
  end

  def parse_input(content) do
    {list1, list2} =
      String.split(content, "\r\n", trim: true)
      |> Enum.map(&line_to_list_of_ints/1)
      |> Enum.map(&List.to_tuple/1)
      |> Enum.unzip()

    {Enum.sort(list1), Enum.sort(list2)}
  end

  def line_to_list_of_ints(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def calculate_distance({list1, list2}) do
    Enum.zip_with(list1, list2, fn a, b -> abs(a - b) end)
  end
end

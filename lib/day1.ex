defmodule AdventOfCode24.Day1 do
  def main do
    input = read_input_to_lists("res/input/day1.txt")

    {input
     |> calculate_distance()
     |> Enum.sum(), input |> similarity_score}
  end

  def read_input_to_lists(path) do
    case File.read(path) do
      {:ok, content} -> parse_input(content)
      {:error, reason} -> IO.puts("failed to read the file: #{reason}")
    end
  end

  def parse_input(content) do
    String.split(content, "\r\n", trim: true)
    |> Enum.map(&line_to_list_of_ints/1)
    |> Enum.map(&List.to_tuple/1)
    |> Enum.unzip()
    |> sort_both
  end

  def sort_both({list1, list2}) do
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

  def similarity_score({list1, list2}) do
    list1
    |> Enum.map(&similarity_for(&1, list2))
    |> Enum.sum()
  end

  def similarity_for(number, list) do
    Enum.count(list, fn x -> x == number end)
    |> then(fn n -> n * number end)
  end
end

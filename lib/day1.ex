defmodule AdventOfCode24.Day1 do
  import AdventOfCode24.Common

  def main do
    input = read_and_parse_input("res/input/day1.txt", &parse_input/1)

    {input
     |> calculate_distance()
     |> Enum.sum(), input |> similarity_score}
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

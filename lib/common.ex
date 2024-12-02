defmodule AdventOfCode24.Common do
  def line_to_list_of_ints(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def read_and_parse_input(path, parse_function) do
    case File.read(path) do
      {:ok, content} -> parse_function.(content)
      {:error, reason} -> IO.puts("failed to read the file: #{reason}")
    end
  end

  def sign(x) when x > 0, do: 1
  def sign(x) when x < 0, do: -1
  def sign(0), do: 0
end

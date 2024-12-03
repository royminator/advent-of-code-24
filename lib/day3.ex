defmodule AdventOfCode24.Day3 do
  import AdventOfCode24.Common

  defmodule InstructionLog,
    do: defstruct instructions: [], should_include: true

  def main() do
    read_and_parse_input("res/input/day3.txt", fn a -> a end)
    |> then(fn x -> {part1(x), part2(x)} end)
  end

  def part1(input) do
    Regex.scan(~r/mul\(\b\d{1,3},\b\d{1,3}\b\)/, input)
    |> List.flatten
    |> extract_multiply_sum
  end

  def extract_multiply_sum(instructions) do
    instructions
    |> Enum.map(&Regex.scan(~r/\d{1,3}/, &1))
    |> Enum.map(&multiply/1)
    |> Enum.sum
  end

  def multiply(pair) do
    pair
    |> List.flatten
    |> Enum.map(&String.to_integer(&1))
    |> then(fn [a, b] -> a * b end)
  end

  def part2(input) do
    Regex.scan(~r/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/, input)
    |> List.flatten
    |> (fn matches ->
        Enum.reduce(matches, %InstructionLog{}, &process_instructions/2)
    end).()
    |> (fn log -> log.instructions end).()
    |> extract_multiply_sum
  end

  def process_instructions("do()", acc), do: %{acc | should_include: true}
  def process_instructions("don't()", acc), do: %{acc | should_include: false}
  def process_instructions(instruction, %InstructionLog{should_include: true} = acc),
    do: %{acc | instructions: [instruction | acc.instructions]}
  def process_instructions(_, acc), do: acc
end

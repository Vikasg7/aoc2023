defmodule Solution do

  def part1({game_id, subsets}) do
    max_balls_by_color = 
      subsets
      |> Enum.reduce([red: 0, green: 0, blue: 0], fn [balls, color], acc ->
        Keyword.update!(acc, String.to_atom(color), fn cur -> max(cur, String.to_integer(balls)) end)
      end)
    possible_game? = 
      max_balls_by_color[:red] <= 12 and
      max_balls_by_color[:green] <= 13 and
      max_balls_by_color[:blue] <= 14
    if possible_game?, do: String.to_integer(game_id), else: 0
  end

  def part2({_, subsets}) do
    min_balls_by_color = 
      subsets
      |> Enum.reduce([red: 0, green: 0, blue: 0], fn [balls, color], acc ->
        Keyword.update!(acc, String.to_atom(color), fn cur -> max(cur, String.to_integer(balls)) end)
      end)
      power_of_set_of_cubes = 
        min_balls_by_color[:red] *
        min_balls_by_color[:green] *
        min_balls_by_color[:blue]
      power_of_set_of_cubes
  end

  @input "input/02.txt"

  def parse_game(line) do
    [game_id, subsets] = String.split(line, ": ")
    game_id = String.split(game_id, " ") |> Enum.at(1)
    subsets =
      subsets
      |> String.split(~r/[;,] /i)
      |> Enum.map(&String.split(&1, " "))
    {game_id, subsets}
  end
  
  def run(func) do
    File.stream!(@input)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_game/1)
    |> Stream.map(func)
    |> Enum.sum()
  end

end

IO.puts(Solution.run(&Solution.part1/1))
IO.puts(Solution.run(&Solution.part2/1))
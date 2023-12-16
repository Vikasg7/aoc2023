defmodule Solution do

  def digit?(c) do
    c in ?0..?9
  end
  
  def recover(line) do
    digits = line |> String.to_charlist() |> Enum.filter(&digit?/1)
    string = to_string([Enum.at(digits, 0), Enum.at(digits, -1)])
    {calibration_value, _} = Integer.parse(string)
    calibration_value
  end

  @spelled_digit_tbl [
    {"one", "o1e"},
    {"two", "t2o"},
    {"three", "t3e"},
    {"four", "f4",},
    {"five", "f5e"},
    {"six", "s6",},
    {"seven", "s7n"},
    {"eight", "e8t"},
    {"nine", "n9e"}
  ]
  
  def recover_with_spelled(line) do
    @spelled_digit_tbl
    |> Enum.reduce(line, fn {spelled, digit}, line ->
      String.replace(line, spelled, digit)
    end)
    |> recover()
  end

  @input "input/01.txt"
  
  def run(func) do
    File.stream!(@input)
    |> Stream.map(&String.trim/1)
    |> Stream.map(func)
    |> Enum.sum()
  end

end

IO.puts(Solution.run(&Solution.recover/1))
IO.puts(Solution.run(&Solution.recover_with_spelled/1))
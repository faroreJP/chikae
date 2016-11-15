defmodule Chikae do

  def main([]) do
    Chikae.Executioner.execute(:help, nil)
  end

  def main(argv) do
    command = hd(argv) |> String.to_atom()
    opt     = Chikae.Parser.parse(command, tl(argv))
    Chikae.Executioner.execute(command, opt)
  end

  def log(str) do
    IO.puts "#{str}"
  end
end

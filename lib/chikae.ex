defmodule Chikae do

  def main([]) do
    Chikae.Executioner.execute(:help, [], %{})
  end

  def main(argv) do
    # extract command from argv
    command = hd(argv) |> String.to_atom()

    case OptionParser.parse(tl(argv)) do
      {opts, arg, []} -> 
        # process specified command
        Chikae.Executioner.execute(command, arg, Enum.into(opts, %{}))

      {_opt, _arg, err} ->
        # error 
        Chikae.log("Parse Error : #{err}")
        exit(:boom)
    end
  end

  def log(str) do
    IO.puts "#{str}"
  end
end

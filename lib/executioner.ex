defmodule Chikae.Executioner do
  use Chikae.Command.List,    :executioner
  use Chikae.Command.Add,     :executioner
  use Chikae.Command.Find,    :executioner
  use Chikae.Command.Update,  :executioner
  use Chikae.Command.Start,   :executioner
  use Chikae.Command.Finish,  :executioner
  use Chikae.Command.Pend,    :executioner

  def execute(:help, _) do
     IO.puts "Chikae is TODO management tool by Elixir"
  end

  def execute(command, _) do
    IO.puts "[chikae] Invalid Command : #{command}"
    exit(:boom)
  end
end

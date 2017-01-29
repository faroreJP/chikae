defmodule Chikae.Parser do
  alias Chikae.Queue

  def parse(_,       []   ), do: %{}
  def parse(command, args ) do
    pid = spawn(Queue, :start, [args])

    parse_all_arguments(%{}, command, pid)
  end

  defp parse_all_arguments(opt, command, pid) do
    case Queue.get(pid) do
      nil -> 
        opt
      arg ->
        parse_argument(opt, command, arg, pid)
        |> parse_all_arguments(command, pid)
    end
  end

  use Chikae.Command.List,    :parser
  use Chikae.Command.Add,     :parser
  use Chikae.Command.Find,    :parser
  use Chikae.Command.Update,  :parser
  use Chikae.Command.Start,   :parser
  use Chikae.Command.Finish,  :parser

  defp parse_argument(_opt, _command, arg, _pid) do
    Chikae.log("Invalid Argument : #{arg}")
    exit(:boom)
  end
end

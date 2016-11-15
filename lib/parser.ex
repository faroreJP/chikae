defmodule Chikae.Parser do
  alias Chikae.Task
  alias Chikae.Repository

  def parse(_,       []   ), do: %{}
  def parse(command, args ), do: parse_all_arguments(%{}, command, hd(args), tl(args))

  defp parse_all_arguments(opt, command, arg, []),    do: parse_argument(opt, command, arg, [])
  defp parse_all_arguments(opt, command, arg, args),  do: parse_argument(opt, command, arg, args) |> parse_all_arguments(command, hd(args), tl(args))

  use Chikae.Command.List, :parser
  use Chikae.Command.Add,  :parser
  use Chikae.Command.Find, :parser

  defp parse_argument(_, _, arg, _) do
    Chikae.log("Invalid Argument : #{arg}")
    exit(:boom)
  end

  def parse("remove", args) do
    IO.puts "[chikae] Removed Task : #{args}"
  end
end

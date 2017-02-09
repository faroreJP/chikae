defmodule Chikae.Executioner do
  use Chikae.Command.List,    :executioner
  use Chikae.Command.Add,     :executioner
  use Chikae.Command.Update,  :executioner
  use Chikae.Command.Start,   :executioner
  use Chikae.Command.Finish,  :executioner
  use Chikae.Command.Pend,    :executioner
  use Chikae.Command.Prune,   :executioner

  def execute(:help, _args, _opts) do
    IO.puts """
    usage:
      chikae <command> [<args>]
    
    command:
      add <name> [--limit <limit>] [--parent {<parent_name> | <parent_uuid>}]
      list [--parent {<name> | <uuid>} [--recursive] | --tree] [--verbose] [--all]
      start {<name> | <uuid>}
      finish {<name> | <uuid>}
      pend {<name> | <uuid>}
      prune
    """
  end

  def execute(command, _opt, _arg) do
    IO.puts "[chikae] Invalid Command : #{command}"
    exit(:boom)
  end
end

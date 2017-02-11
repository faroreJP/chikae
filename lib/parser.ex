defmodule Chikae.Parser do
  use Chikae.Command.List,    :parser
  use Chikae.Command.Add,     :parser
  use Chikae.Command.Update,  :parser

  def get_requirements(command, _switches, _aliases) do
    Chikae.log("Invalid coomand! : #{command}")
    exit(:boom)
  end

  def get_requirements(command) do
    get_requirements(command, [], [])
  end

end

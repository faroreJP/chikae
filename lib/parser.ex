defmodule Chikae.Parser do
  use Chikae.Command.List,    :parser
  use Chikae.Command.Add,     :parser
  use Chikae.Command.Update,  :parser

  def get_requirements(command) do
    Chikae.log("Invalid command! : #{command}")
    exit(:boom)
  end

end

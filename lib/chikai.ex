defmodule Chikai do

  @moduledoc """
  The TODO Management Tool
  """

  def main(argv) do
    Process.flag(:trap_exit, true)

    # Devide Command and Arguments
    [ command | arguments ] = argv

    Chikai.Parser.execute(command, arguments)

    # args
    # |> Enum.each( fn(x) -> IO.puts(x) end )
  end

  def log(str) do
    IO.puts "[chikai]#{str}"
  end
end

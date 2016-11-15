defmodule Chikae.Parser do
  import DateTime

  alias Chikae.Task
  alias Chikae.Repository

  def execute("add", args) do
    task = %Task{uuid: 0, name: hd(args), date_time: to_unix(utc_now())}

    Repository.insert(task)
    Chikae.log("Added Task : #{task.name}")
  end

  def execute("list", args) do
    tasks = Repository.get_all()
    Enum.each( tasks, fn(x) -> Task.print(x) end )
  end

  def execute("find", args) do
    Repository.get( String.to_integer(hd(args)) )
    |> Task.print
  end

  def execute("remove", args) do
    IO.puts "[chikae] Removed Task : #{args}"
  end

  def execute(command, args) do
    IO.puts "[chikae] Invalid Command : #{command}"
  end

end

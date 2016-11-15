defmodule Chikae.Task do
  import DateTime

  defstruct uuid:         0, 
            name:         "", 
            date_time:    0

  def print(task) do
    date = from_unix!(task.date_time)
    IO.puts("#{task.uuid} #{task.name} #{to_iso8601(date)}") 
  end
end

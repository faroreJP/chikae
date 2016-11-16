defmodule Chikae.Repository do
  defp file_name(), do: "tasks.json"

  def get_all() do
    case File.read file_name() do
      {:ok, jsons} ->
        Poison.Parser.parse!(jsons, keys: :atoms!)
      {_, _} ->
        []
    end
  end

  def insert(task) do
    tasks = get_all() ++ [task]
    json  = to_string(Poison.Encoder.encode(tasks, []))

    File.write file_name(), json, [:write, :utf8]
    task
  end

  def update(task) do

  end
end

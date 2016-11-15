defmodule Chikae.Repository do

  def get_all() do
    case File.read "tasks.bin" do
      {:ok, jsons} ->
        Poison.Parser.parse!(jsons, keys: :atoms!)
      {_, _} ->
        []
    end
  end

  def insert(task) do
    tasks = get_all() ++ [task]
    json  = to_string(Poison.Encoder.encode(tasks, []))

    File.write "tasks.bin", json, [:write, :utf8]
    task
  end

  def update(task) do

  end
end

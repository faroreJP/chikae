defmodule Chikae.Repository do
  defp file_name(), do: "tasks.json"

  def get_all() do
    case File.open(file_name(), [:read, :utf8]) do
      {:ok, fp} ->
        IO.read(fp, :all)
        |> Poison.Parser.parse!(keys: :atoms!)
      {:error, _} ->
        []
    end
  end

  def insert(task) do
    tasks = get_all() ++ [task]
    json  = to_string(Poison.Encoder.encode(tasks, []))

    File.open!(file_name(), [:write, :utf8])
    |> IO.write(json)

    task
  end

  def update(task) do

  end
end

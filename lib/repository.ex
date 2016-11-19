defmodule Chikae.Repository do
  alias Chikae.Task

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

  def get(:uuid, uuid) do
    validate_specified_uuid(uuid)

    tasks = get_all() 
    index = find_index(tasks, uuid)

    Enum.at(tasks, index) 
  end

  def find_index(tasks, uuid) do
    Enum.find_index(tasks, fn(x) -> String.starts_with?(x.uuid, uuid) end)
  end

  def set_all(tasks) do
    json  = to_string(Poison.Encoder.encode(tasks, []))

    File.open!(file_name(), [:write, :utf8])
    |> IO.write(json)
  end

  def set(task) do
    tasks = get_all()
    index = find_index(tasks, task.uuid)

    tasks
    |> List.replace_at(index, task)
    |> set_all()
  end

  def insert(task) do
    get_all()
    |> Enum.concat([task])
    |> set_all()

    task
  end

  def validate_specified_uuid(uuid) do
    if String.length(uuid) >= 8 do
      true
    else
      exit(:boom)
    end
  end
end

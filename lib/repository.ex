defmodule Chikae.Repository do

  defp file_name() do
    directory = Chikae.Constants.get_persistent_path()

    if !File.exists?(directory) do 
      File.mkdir(directory)
    end

    directory <> "tasks.json"
  end

  #------------------------------------------------------------------------------------------
  # Get
  #------------------------------------------------------------------------------------------

  def get_all() do
    case File.open(file_name(), [:read, :utf8]) do
      {:ok, fp} ->
        IO.read(fp, :all)
        |> Poison.Parser.parse!(keys: :atoms)
      {:error, _} ->
        []
    end
  end

  def get(:uuid, uuid) do
    validate_specified_uuid(uuid)
    tasks = get_all() 
    case find_index_by_uuid(tasks, uuid) do
      nil -> 
        nil
      index ->
        Enum.at(tasks, index) 
    end
  end

  def get(:name, name) do
    tasks = get_all() 
    case Enum.find_index(tasks, fn(x) -> x.name == name end) do
      nil ->
        nil
      index ->
        Enum.at(tasks, index)
    end
  end

  #------------------------------------------------------------------------------------------
  # Set
  #------------------------------------------------------------------------------------------

  def set_all(tasks) do
    json  = to_string(Poison.Encoder.encode(tasks, []))

    File.open!(file_name(), [:write, :utf8])
    |> IO.write(json)
  end

  def set(task) do
    tasks = get_all()
    index = find_index_by_uuid(tasks, task.uuid)

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

  def remove(task) do
    get_all()
    |> Enum.filter( fn(x) -> x.uuid != task.uuid end )
    |> set_all()

    task
  end

  #------------------------------------------------------------------------------------------
  # Util
  #------------------------------------------------------------------------------------------

  def find_index_by_uuid(tasks, uuid) do
    Enum.find_index(tasks, fn(x) -> String.starts_with?(x.uuid, uuid) end)
  end

  def validate_specified_uuid(uuid) do
    if String.length(uuid) >= 8 do
      true
    else
      Chikae.log("uuid must be 8 or longer than!")
      exit(:boom)
    end
  end
end

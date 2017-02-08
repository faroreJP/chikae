defmodule Chikae.Task do
  defstruct uuid: "", name: "New-Task", date: NaiveDateTime.utc_now(), limit: "", state: "TODO", category: "work", parent: "", is_pruned: false

  #------------------------------------------------------------------------------------------
  # Print 
  #------------------------------------------------------------------------------------------

  def print(task) do
    to_s(task, %{})
    |> IO.puts()
  end

  #------------------------------------------------------------------------------------------
  # Generate
  #------------------------------------------------------------------------------------------

  def gen(opt) do

    date = get_current_time()
           |> NaiveDateTime.to_string()

    %Chikae.Task{uuid: UUID.uuid4(), date: date}
    |> put_name(opt)
    |> put_state(opt)
    |> put_category(opt)
    |> put_limit(opt)
    |> put_parent(opt)
  end

  def put_name(task, %{:name => name}),             do: Map.put(task, :name, name)
  def put_name(task, _),                            do: task

  def put_state(task, %{:state => state}),          do: Map.put(task, :state, state)
  def put_state(task, _),                           do: task

  def put_category(task, %{:category => category}), do: Map.put(task, :category, category)
  def put_category(task, _),                        do: task

  def put_date(task, %{:date => date}),             do: Map.put(task, :date, date)
  def put_date(task, _),                            do: task

  def put_limit(task, %{:limit => limit}) do
    case NaiveDateTime.from_iso8601(limit) do
      {:ok, time} ->
        Map.put(task, :limit, NaiveDateTime.to_string(time) )
      {:error, _} ->
        Chikae.log("invalid date time format!")
        exit(:boom)
    end
  end
  def put_limit(task, _), do: task

  def put_parent(task, %{:parent => parent}) do 
    parent_task = case Chikae.Repository.get(:name, parent) do
      nil -> 
        Chikae.Repository.get(:uuid, parent)
      parent_task ->
        parent_task
    end

    if parent_task == nil do
      Chikae.log("task '#{parent}' is not found!")
      exit(:boom)
    end

    Map.put(task, :parent, parent_task.uuid)
  end

  def put_parent(task, _), do: task

  defp get_current_time() do
    {erl_date, erl_time} = :calendar.local_time()
    {:ok, date}          = NaiveDateTime.new( Date.from_erl!(erl_date), Time.from_erl!(erl_time) )

    date
  end

  #------------------------------------------------------------------------------------------
  # To String
  #------------------------------------------------------------------------------------------

  def to_s(task, opt \\ %{}) do
    ""
    |> uuid_to_s(task, opt)
    |> state_to_s(task, opt)
    |> category_to_s(task, opt)
    |> date_to_s(task, opt)
    |> limit_to_s(task, opt)
    |> parent_to_s(task, opt)
    |> name_to_s(task, opt)
  end

  defp uuid_to_s(str, task, %{verbose: true, raw: true}), do: "#{str}#{task.uuid} "
  defp uuid_to_s(str, task, %{verbose: true}),            do: "#{str}\u001b[33m#{task.uuid} "
  defp uuid_to_s(str, task, %{raw: true}),                do: "#{str}#{String.split(task.uuid, "-") |> hd()} "
  defp uuid_to_s(str, task, _),                           do: "#{str}\u001b[33m#{String.split(task.uuid, "-") |> hd()} "

  defp state_to_s(str, task,  %{raw: true}),    do: "#{str}[#{task.state}]#{String.duplicate(" ", 8 - string_width(task.state))} "
  defp state_to_s(str, %{state: "DOING"}, _),   do: "#{str}\u001b[31m[DOING]#{String.duplicate(" ", 8 - string_width("DOING"))} "
  defp state_to_s(str, %{state: "DONE"}, _),    do: "#{str}\u001b[36m[DONE]#{String.duplicate(" ", 8 - string_width("DONE"))} "
  defp state_to_s(str, task,  _),               do: "#{str}\u001b[0m[#{task.state}]#{String.duplicate(" ", 8 - string_width(task.state))} "

  defp parent_to_s(str, task, %{type: :directory}), do: "#{str}\u001b[0m/#{find_parent("", task.parent)}"
  defp parent_to_s(str, _, _),                      do: str

  defp find_parent(str, ""), do: str
  defp find_parent(str, parent_uuid) do
    parent_task = Chikae.Repository.get(:uuid, parent_uuid)
    find_parent("#{parent_task.name}/#{str}", parent_task.parent)
  end

  defp name_to_s(str, task, _) do
    if task.is_pruned do
      "#{str}\u001b[0m*#{task.name} "
    else 
      "#{str}\u001b[0m#{task.name} "
    end 
  end

  defp category_to_s(str, task, _), do: "#{str}\u001b[0m<#{task.category}>#{String.duplicate(" ", 7 - string_width(task.category))} "

  defp date_to_s(str, task, %{verbose: true}),            do: "#{str}\u001b[0m#{task.date} "
  defp date_to_s(str, _, _),                              do: str

  defp limit_to_s(str, %{limit: ""}, _),  do: "#{str}\u001b[0m"
  defp limit_to_s(str, task, _),          do: "#{str}\u001b[0m#{task.limit} "

  defp string_width(str) do
    String.codepoints(str)
    |> List.foldl(0, fn(x, acc) -> acc + char_size(x) end)
  end

  defp char_size(c) do
    case byte_size(c) do
      1 ->
        1
      _ ->
        2
    end
  end

end

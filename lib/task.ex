defmodule Chikae.Task do
  defstruct uuid: "", name: "New-Task", date: 0, limit: 0, state: "TODO", category: "work", parent: ""

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
    date  = DateTime.utc_now()
            |> DateTime.to_unix()

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

  def put_limit(task, %{:limit => limit}),          do: Map.put(task, :limit, limit)
  def put_limit(task, _),                           do: task

  def put_parent(task, %{:parent => parent}) do 
    parent_task = Chikae.Repository.get(:name, parent)
    if parent_task != nil do
      Map.put(task, :parent, parent_task.uuid)
    else
      parent_task = Chikae.Repository.get(:uuid, parent)
      if parent_task == nil do
        Chikae.log("task '#{parent}' is not found!")
        exit(:boom)
      end
    end
  end

  def put_parent(task, _), do: task

  #------------------------------------------------------------------------------------------
  # To String
  #------------------------------------------------------------------------------------------

  def to_s(task, opt \\ %{}) do
    ""
    |> state_to_s(task, opt)
    |> uuid_to_s(task, opt)
    |> name_to_s(task, opt)
    |> parent_to_s(task, opt)
    |> category_to_s(task, opt)
    |> date_to_s(task, opt)
    |> limit_to_s(task, opt)
  end


  defp uuid_to_s(str, task, %{uuid: true, verbose: true, raw: true}), do: "#{str}#{task.uuid} "
  defp uuid_to_s(str, task, %{uuid: true, verbose: true}),            do: "#{str}\u001b[33m#{task.uuid} "
  defp uuid_to_s(str, task, %{uuid: true, raw: true}),                do: "#{str}#{String.split(task.uuid, "-") |> hd()} "
  defp uuid_to_s(str, task, %{uuid: true}),                           do: "#{str}\u001b[33m#{String.split(task.uuid, "-") |> hd()} "
  defp uuid_to_s(str, task, _),                                       do: str

  defp state_to_s(str, task,  %{raw: true}),            do: "#{str}[#{task.state}]#{String.duplicate(" ", 10 - string_width("[#{task.state}]"))} "
  defp state_to_s(str, task,  _),                       do: "#{str}\u001b[31m[#{task.state}]#{String.duplicate(" ", 10 - string_width("[#{task.state}]"))} "

  defp name_to_s(str, task, _), do: "#{str}\u001b[0m#{task.name}#{String.duplicate(" ", 30 - string_width(task.name))} "

  defp category_to_s(str, task, %{raw: true}),            do: "#{str}<#{task.category}>#{String.duplicate(" ", 12 - string_width("<#{task.category}>"))} "
  defp category_to_s(str, task, _),                       do: "#{str}\u001b[32m<#{task.category}>#{String.duplicate(" ", 12 - string_width("<#{task.category}>"))} "

  defp date_to_s(str, task, %{verbose: true, raw: true}), do: "#{str}#{DateTime.to_iso8601(DateTime.from_unix!(task.date))} "
  defp date_to_s(str, task, %{verbose: true}),            do: "#{str}\u001b[36m#{DateTime.to_iso8601(DateTime.from_unix!(task.date))}\u001b[0m "
  defp date_to_s(str, task, _),                           do: str

  defp limit_to_s(str, task, %{raw: true}),         do: "#{str}#{DateTime.to_iso8601(DateTime.from_unix!(task.limit))} "
  defp limit_to_s(str, task, _),                    do: "#{str}\u001b[35m#{DateTime.to_iso8601(DateTime.from_unix!(task.limit))}\u001b[0m "

  defp parent_to_s(str, task, %{tree: true}), do: str
  defp parent_to_s(str, task, %{verbose: true}) do
    if task.parent == "" do
      "#{str}<none>#{String.duplicate(" ", 30 - string_width("<none>"))} "
    else 
      case Chikae.Repository.get(:uuid, task.parent) do
        nil ->
          "#{str}<missing>#{String.duplicate(" ", 30 - string_width("<missing>"))} "
        parent_task ->
          "#{str}#{parent_task.name}#{String.duplicate(" ", 30 - string_width(parent_task.name))} "
      end
    end
  end
  defp parent_to_s(str, task, _), do: str


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

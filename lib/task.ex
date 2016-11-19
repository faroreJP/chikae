defmodule Chikae.Task do
  defstruct uuid: "", name: "New Task", date: 0, state: "NOT-YET"

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
  end

  def put_name(task, %{:name => name}),       do: Map.put(task, :name, name)
  def put_name(task, _),                      do: task

  def put_state(task, %{:state => state}),    do: Map.put(task, :state, state)
  def put_state(task, _),                     do: task

  def put_date(task, opt, %{:date => date}),  do: Map.put(task, :date, date)
  def put_date(task, opt, _)               ,  do: task

  #------------------------------------------------------------------------------------------
  # To String
  #------------------------------------------------------------------------------------------

  def to_s(task, opt \\ %{}) do
    date  = DateTime.from_unix!(task.date)
    uuid  = uuid_to_s(task, opt)
    state = state_to_s(task, opt)

    "\u001b[33m#{uuid} \u001b[31m#{state} \u001b[0m#{task.name} \u001b[36m#{DateTime.to_iso8601(date)}\u001b[0m"
  end

  defp uuid_to_s(task, %{:uuid => true}), do: task.uuid
  defp uuid_to_s(task, opt),              do: String.split(task.uuid, "-") |> hd()

  defp state_to_s(task, %{:hide_state => true}),  do: ""
  defp state_to_s(task, opt),                     do: "[#{task.state}]"
end

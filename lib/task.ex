defmodule Chikae.Task do
  defstruct uuid: "", name: "", date: 0, state: ""

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
    name  = gen_name(opt)
    date  = DateTime.utc_now()
            |> DateTime.to_unix()
    state = gen_state(opt)

    %Chikae.Task{uuid: UUID.uuid4(), name: name, date: date, state: state}
  end

  defp gen_name(%{:name => name}),  do: name
  defp gen_name(_),                 do: "new-task"

  defp gen_state(%{:state => state}), do: state
  defp gen_state(_),                  do: "not-yet"

  #------------------------------------------------------------------------------------------
  # To String
  #------------------------------------------------------------------------------------------

  def to_s(task, opt) do
    date  = DateTime.from_unix!(task.date)
    uuid  = uuid_to_s(task, opt)
    state = state_to_s(task, opt)

    "\u001b[33m#{uuid}\u001b[37m \u001b[031m#{state}\u001b[37m #{task.name} \u001b[36m#{DateTime.to_iso8601(date)}\u001b[37m"
  end

  defp uuid_to_s(task, %{:uuid => true}), do: task.uuid
  defp uuid_to_s(task, opt),              do: String.split(task.uuid, "-") |> hd()

  defp state_to_s(task, %{:hide_state => true}),  do: ""
  defp state_to_s(task, opt),                     do: "[#{task.state}]"

end

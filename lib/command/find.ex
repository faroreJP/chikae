defmodule Chikae.Command.Find do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt,  :find,  "--uuid",   pid), do: Map.put(opt, :uuid,  Queue.get(pid))
      defp parse_argument(opt,  :find,  "--state",  pid), do: Map.put(opt, :state, Queue.get(pid))
    end
  end

  defmacro __using__(:executioner) do
    quote do
      def execute(:find, opt) do
        tasks = Repository.get_all()

        []
        |> Chikae.Command.Find.find_by_uuid(tasks,  opt)
        |> Chikae.Command.Find.find_by_state(tasks, opt)
        |> List.foldl("", fn(x, acc) -> "#{acc}#{Chikae.Task.to_s(x, %{})}\r\n" end)
        |> IO.write()
      end
    end
  end

  def find_by_uuid( found, tasks, %{:uuid  => uuid }),   do: found ++ [Enum.find(tasks, fn(x) -> String.starts_with?(x.uuid, uuid) end)]
  def find_by_uuid( found, tasks, _                 ),   do: found

  def find_by_state(found, tasks, %{:state => state}),   do: found ++ [Enum.find(tasks, fn(x) -> x.state == state end)]
  def find_by_state(found, tasks, _                 ),   do: found

end

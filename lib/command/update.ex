defmodule Chikae.Command.Update do
  alias Chikae.Task
  alias Chikae.Repository
  alias Chikae.Queue

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt,  :update,  "--uuid",   pid),  do: Map.put(opt, :uuid,  Queue.get(pid))
      defp parse_argument(opt,  :update,  "--state",  pid),  do: Map.put(opt, :state, Queue.get(pid))
      defp parse_argument(opt,  :update,  "--name",   pid),  do: Map.put(opt, :name,  Queue.get(pid))
    end
  end

  defmacro __using__(:executioner) do
    quote do
      def execute(:update, opt) do
        task =  Repository.get(:uuid, opt.uuid)
                |> Task.put_name(opt)
                |> Task.put_state(opt)

        Task.to_s(task)
        |> IO.write()

        Repository.set(task)
      end
    end
  end
end

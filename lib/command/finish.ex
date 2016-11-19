defmodule Chikae.Command.Finish do
  alias Chikae.Task
  alias Chikae.Repository
  alias Chikae.Queue

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt,  :finish,  "--uuid",   pid),  do: Map.put(opt, :uuid,  Queue.get(pid))
    end
  end

  defmacro __using__(:executioner) do
    quote do
      def execute(:finish, opt) do
        task =  Repository.get(:uuid, opt.uuid)
                |> Task.put_state(%{state: "DONE"})

        Task.to_s(task)
        |> IO.write()

        Repository.set(task)
      end
    end
  end
end

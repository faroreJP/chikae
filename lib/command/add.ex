defmodule Chikae.Command.Add do
  alias Chikae.Task
  alias Chikae.Repository
  alias Chikae.Queue

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt,  :add,  "--name",    pid), do: Map.put(opt, :name,   Queue.get(pid))
      defp parse_argument(opt,  :add,  "--state",   pid), do: Map.put(opt, :state,  Queue.get(pid))
      defp parse_argument(opt,  :add,  "--tag",     pid), do: Map.put(opt, :tag,    Queue.get(pid))
      defp parse_argument(opt,  :add,  "--parent",  pid), do: Map.put(opt, :parent, Queue.get(pid))
    end
  end

  defmacro __using__(:executioner) do
    quote do
      def execute(:add, args) do
        task =  Task.gen(args)
                |> Repository.insert()
                |> Task.to_s(args)

        Chikae.log("Added Task:\r\n#{task}")
      end
    end
  end
end

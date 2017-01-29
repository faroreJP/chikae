defmodule Chikae.Command.Add do
  alias Chikae.Task
  alias Chikae.Repository
  alias Chikae.Queue

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt, :add, "--category", pid), do: Map.put(opt, :category, Queue.get(pid))

      defp parse_argument(opt, :add, "--limit", pid), do: Map.put(opt, :limit, Queue.get(pid))

      defp parse_argument(opt, :add, "--parent", pid), do: Map.put(opt, :parent, Queue.get(pid))

      defp parse_argument(opt, :add, name, pid) do
        case Map.has_key?(opt, :name) do
          false -> 
            Map.put(opt, :name, name)
          true ->
            Chikae.log("name has already specified! (#{name}/#{Map.get(opt, :name)})")
            exit(:boom)
            opt
        end
      end

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

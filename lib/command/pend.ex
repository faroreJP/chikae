defmodule Chikae.Command.Pend do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt, :pend, name, pid) do
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
      def execute(:pend, opt) do
        task = case Repository.get(:name, opt.name) do
          nil ->
            Repository.get(:uuid, opt.name)
          task ->
            task
        end

        if task == nil do
          Chikae.log("#{opt.name} is not found!")
          exit(:boom)
        else
          Chikae.log("#{task.name} has been pended!")

          task
          |> Task.put_state(%{state: "PENDING"})
          |> Repository.set()
        end
      end
    end
  end
end

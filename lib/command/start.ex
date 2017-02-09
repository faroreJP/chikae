defmodule Chikae.Command.Start do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:executioner) do
    quote do
      def execute(:start, [name], _opts) do
        case Repository.get(name) do
          nil ->
            # error
            Chikae.log("#{name} is not found!")
            exit(:boom)

          task ->
            # start
            Chikae.log("#{task.name} has been started!")
            task
            |> Task.put_state(%{state: "DOING"})
            |> Repository.set()
        end
      end

      def execute(:start, args, _opts) do
        Chikae.log("Invalid Argument! : #{args}")
        exit(:boom)
      end
    end
  end
end

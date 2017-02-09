defmodule Chikae.Command.Pend do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:executioner) do
    quote do
      def execute(:pend, [name], _opts) do
        case Repository.get(name) do
          nil ->
            # error
            Chikae.log("#{name} is not found!")
            exit(:boom)

          task ->
            # pend
            Chikae.log("#{task.name} has been pended")
            task
            |> Task.put_state(%{state: "PENDING"})
            |> Repository.set()
        end
      end

      def execute(:pend, args, _opts) do
        Chikae.log("Invalid Argument! : #{args}")
        exit(:boom)
      end
    end
  end
end

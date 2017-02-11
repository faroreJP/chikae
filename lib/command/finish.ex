defmodule Chikae.Command.Finish do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:executioner) do
    quote do
      def execute(:finish, [name], _opts) do
        case Repository.get(name) do
          nil ->
            # error
            Chikae.log("#{name} is not found!")
            exit(:boom)

          task ->
            # finish
            Chikae.log("#{task.name} has been finished!")
            task
            |> Task.put_state(%{state: "DONE"})
            |> Repository.set()
        end
      end

      def execute(:finish, args, _opts) do
        Chikae.log("Invalid Argument! : #{args}")
        exit(:boom)
      end
    end
  end
end

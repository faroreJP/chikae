defmodule Chikae.Command.Update do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:parser) do
    quote do
      def get_requirements(:update) do
        switches = []
                   |> Keyword.put(:parent, :string)
                   |> Keyword.put(:category, :string)
                   |> Keyword.put(:limit, :string)

        {:ok, switches, []}
      end
    end
  end

  defmacro __using__(:executioner) do
    quote do
      def execute(:update, [name], opts) do
        case Repository.get(name) do
          nil ->
            # error
            Chikae.log("#{name} is not found!")
            exit(:boom)

          task ->
            # update
            updated_task = task
                           |> Task.put_name(opts)
                           |> Task.put_category(opts)
                           |> Task.put_limit(opts)

            Task.to_s(updated_task, opts)
            |> IO.write()
            Repository.set(task)
        end
      end

      def execute(:update, args, _opts) do
        Chikae.log("Invalid Argument! : #{args}")
        exit(:boom)
      end
    end
  end
end

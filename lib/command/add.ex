defmodule Chikae.Command.Add do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:executioner) do
    quote do
      def execute(:add, [name], opts) do
        task =  Map.put(opts, :name, name)
                |> Task.gen()
                |> Repository.insert()
                |> Task.to_s(opts)

        Chikae.log("Added Task:\r\n#{task}")
      end

      def execute(:add, _args, opts) do
        Chikae.log("Parse Error : name is invalid or missing")
      end
    end
  end
end

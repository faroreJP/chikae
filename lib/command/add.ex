defmodule Chikae.Command.Add do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:parser) do
    quote do
      def get_requirements(:add, switches, aliases) do
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

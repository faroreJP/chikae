defmodule Chikae.Command.Add do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt,  :add,  "--name",  args), do: Map.put(opt, :name,  hd(args))
      defp parse_argument(opt,  :add,  "--state", args), do: Map.put(opt, :state, hd(args))
      defp parse_argument(opt,  :add,  "--tag",   args), do: Map.put(opt, :tag,   hd(args))
      defp parse_argument(opt,  :add,  _,         _   ), do: opt
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

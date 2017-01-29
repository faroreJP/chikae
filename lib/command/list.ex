defmodule Chikae.Command.List do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt,  :list,  "--uuid",     _),   do: Map.put(opt, :uuid,     true)
      defp parse_argument(opt,  :list,  "--raw",      _),   do: Map.put(opt, :raw,      true)
      defp parse_argument(opt,  :list,  "--verbose",  _),   do: Map.put(opt, :verbose,  true)
    end
  end

  defmacro __using__(:executioner) do
    quote do
      def execute(:list, opt) do
        Repository.get_all()
        |> List.foldl("", fn(x, acc) -> "#{acc}#{Task.to_s(x, opt)}\r\n" end)
        |> IO.write()
      end
    end
  end
end

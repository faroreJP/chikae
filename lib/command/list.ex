defmodule Chikae.Command.List do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt,  :list,  "--directory",_), do: Map.put(opt, :type,     :directory)
      defp parse_argument(opt,  :list,  "--uuid", _),     do: Map.put(opt, :uuid,     true)
      defp parse_argument(opt,  :list,  "--raw", _),      do: Map.put(opt, :raw,      true)
      defp parse_argument(opt,  :list,  "--verbose", _),  do: Map.put(opt, :verbose,  true)
      defp parse_argument(opt,  :list,  "--all", _),      do: Map.put(opt, :all,      true)
    end
  end

  defmacro __using__(:executioner) do
    quote do
      def execute(:list, opt) do
        Repository.get_all()
        |> Enum.filter( fn(x) -> is_all(opt) or !x.is_pruned end )
        |> List.foldl("", fn(x, acc) -> "#{acc}#{Task.to_s(x, opt)}\r\n" end)
        |> IO.write()
      end

      defp is_all(%{all: true}), do: true
      defp is_all(_opt),         do: false
    end
  end
end

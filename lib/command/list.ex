defmodule Chikae.Command.List do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt,  :list,  "--uuid",           _), do: Map.put(opt, :uuid,         true)
      defp parse_argument(opt,  :list,  "--no-color",       _), do: Map.put(opt, :no_color,     true)
      defp parse_argument(opt,  :list,  "--hide-state",     _), do: Map.put(opt, :hide_state,   true)
      defp parse_argument(opt,  :list,  "--hide-category",  _), do: Map.put(opt, :hit_category, true)
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

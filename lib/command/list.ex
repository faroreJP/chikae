defmodule Chikae.Command.List do
  alias Chikae.Task
  alias Chikae.Repository
  alias Chikae.Queue

  defmacro __using__(:parser) do
    quote do
      defp parse_argument(opt,  :list,  "--uuid",           _),   do: Map.put(opt, :uuid,         true)
      defp parse_argument(opt,  :list,  "--no-color",       _),   do: Map.put(opt, :no_color,     true)
      defp parse_argument(opt,  :list,  "--hide-state",     _),   do: Map.put(opt, :hide_state,   true)
      defp parse_argument(opt,  :list,  "--hide-category",  _),   do: Map.put(opt, :hit_category, true)
      defp parse_argument(opt,  :list,  "--root-only",      _),   do: Map.put(opt, :root_only,    true)
      defp parse_argument(opt,  :list,  "--parent",         pid), do: Map.put(opt, :parent,       Queue.get(pid))
    end
  end

  defmacro __using__(:executioner) do
    quote do
      def execute(:list, opt) do
        Repository.get_all()
        |> Chikae.Command.List.filter_root(opt)
        |> Chikae.Command.List.filter_parent(opt)
        |> List.foldl("", fn(x, acc) -> "#{acc}#{Task.to_s(x, opt)}\r\n" end)
        |> IO.write()
      end
    end
  end

  def filter_root(tasks, %{:root_only => true}),  do: Enum.filter(tasks, fn(x) -> String.equivalent?(x.parent, "nil") end)
  def filter_root(tasks, _),                      do: tasks

  def filter_parent(tasks, %{:parent => parent}) do
    case Repository.get(:uuid, parent) do
      nil ->
        []
      p ->
        Enum.filter(tasks, fn(x) -> String.starts_with?(p.uuid, x.parent) end)
    end
  end
  def filter_parent(tasks, _), do: tasks

end

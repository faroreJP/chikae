defmodule Chikae.Command.List do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:executioner) do
    quote do
      def execute(:list, _args, opts) do

        # set default list type when :type is not specified
        opts = case Map.fetch(opts, :type) do
          {:ok, _} -> opts
          :error -> Map.put(opts, :type, :directory)
        end

        Repository.get_all()
        |> Enum.filter( fn(x) -> is_all(opts) or !x.is_pruned end )
        |> List.foldl("", fn(x, acc) -> "#{acc}#{Task.to_s(x, opts)}\r\n" end)
        |> IO.write()
      end

      defp is_all(%{all: true}), do: true
      defp is_all(_opts),        do: false
    end
  end
end

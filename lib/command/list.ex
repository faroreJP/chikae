defmodule Chikae.Command.List do
  alias Chikae.Task
  alias Chikae.Repository

  defmacro __using__(:parser) do
    quote do
      def get_requirements(:list) do
        switches = []
                   |> Keyword.put(:type, :string)
                   |> Keyword.put(:parent, :string)
                   |> Keyword.put(:recursive, :boolean)
                   |> Keyword.put(:directory, :boolean)
                   |> Keyword.put(:tree, :boolean)
                   |> Keyword.put(:verbose, :boolean)
                   |> Keyword.put(:all, :boolean)

        aliases = []
                  |> Keyword.put(:r, :recursive)
                  |> Keyword.put(:v, :verbose)
                  |> Keyword.put(:a, :all)

        {:ok, switches, aliases}
      end
    end
  end

  defmacro __using__(:executioner) do
    quote do
      def execute(:list, _args, opts) do

        # set default list type when :type is not specified
        type = get_type(:list, opts)
        opts = Map.put(opts, :type, type)
        all  = is_all(:list, opts)

        Repository.get_all()
        |> Enum.filter( fn(x) -> all or !x.is_pruned end )
        |> List.foldl("", fn(x, acc) -> "#{acc}#{Task.to_s(x, opts)}\r\n" end)
        |> IO.write()
      end

      defp is_all(:list, %{all: true}), do: true
      defp is_all(:list, _opts),        do: false

      defp get_type(:list, [directory: true]), do: :directory
      defp get_type(:list, [tree: true]),      do: :tree
      defp get_type(:list, [type: type]),      do: String.to_atom(type)
      defp get_type(:list, opts),              do: :directory
    end
  end
end

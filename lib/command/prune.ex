defmodule Chikae.Command.Prune do
  alias Chikae.Repository

  defmacro __using__(:executioner) do
    quote do
      def execute(:prune, _args, _opts) do
        pruned_tasks = Repository.get_all()
                       |> Enum.filter( fn(x) -> !x.is_pruned and x.state == "DONE" end )

        Enum.map(pruned_tasks, fn(x) -> Map.put(x, :is_pruned, true) end )
        |> Enum.map( fn(x) -> Repository.set(x) end )

        case Enum.count(pruned_tasks) do
          0 ->
            # did nothing
            Chikae.log("already updated")

          count ->
            # list up pruned tasks
            Enum.reduce(pruned_tasks, "pruned #{count} task!", fn(x, acc) -> "#{acc}\n * #{x.name}" end )
            |> Chikae.log()
        end
      end
    end
  end
end


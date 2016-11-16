defmodule Chikae.Queue do

  def start(args) do
    loop(args)
  end

  def get(pid) do
    send pid, {:get, self}
    receive do
      arg ->
        arg
    end
  end


  defp loop([]) do
    receive do
      {:get, sender} ->
        send sender, nil
        loop([])
    end
  end

  defp loop(args) do
    receive do
      {:get, sender} ->
        send sender, hd(args)
        loop(tl(args))
    end
  end
end

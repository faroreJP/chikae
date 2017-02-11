defmodule Chikae.Constants do
  def get_persistent_path() do
    directory = Path.expand("~/.chikae") <> "/"

    if !File.exists?(directory) do 
      File.mkdir(directory)
    end

    directory
  end
end

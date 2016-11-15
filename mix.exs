defmodule Chikae.Mixfile do
  use Mix.Project

  def project do
    [app: :chikae,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     escript: escript_config]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  def escript_config do
    [ main_module: Chikae ]
  end

  defp deps do
    [{:poison,  "~> 3.0"},
     {:uuid,    "~> 1.1"}]
  end
end

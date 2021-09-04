defmodule Exercism.MixProject do
  use Mix.Project

  def project do
    [
      app: :exercism,
      version: "0.1.0",
      elixir: "~> 1.11",
      deps: deps()
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false}
    ]
  end
end

defmodule ExUnitNotifier.MixProject do
  use Mix.Project

  @source_url "https://github.com/navinpeiris/ex_unit_notifier"
  @version "1.3.0"

  def project do
    [
      app: :ex_unit_notifier,
      version: @version,
      name: "ExUnitNotifier",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev}
    ]
  end

  defp docs do
    [
      extras: [{:"LICENSE.md", [title: "License"]}, "README.md"],
      main: "readme",
      source_url: @source_url,
      formatters: ["html"],
      api_reference: false
    ]
  end

  defp package do
    [
      description: "Show status notifications for ExUnit test runs",
      files: ["lib", "priv", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Navin Peiris"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end

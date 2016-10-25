defmodule ExUnitNotifier.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_unit_notifier,
     version: "0.1.1",
     name: "ExUnitNotifier",
     description: "Show status notifications for ExUnit test runs",
     source_url: "https://github.com/navinpeiris/ex_unit_notifier",
     homepage_url: "https://github.com/navinpeiris/ex_unit_notifier",
     package: package,
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     docs: [extras: ["README.md"]]]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [{:earmark, "~> 1.0", only: :dev},
     {:ex_doc, "~> 0.14", only: :dev},

     {:mix_test_watch, "~> 0.2", only: :dev}]
  end

  defp package do
    [files: ["lib", "priv", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Navin Peiris"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/navinpeiris/ex_unit_notifier"}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]
end

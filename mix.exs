defmodule ExUnitNotifier.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_unit_notifier,
     version: "0.1.0",
     description: "Desktop notifications for ExUnit",
     package: package,
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:mix_test_watch, "~> 0.2", only: :dev}]
  end

  defp package do
    [files: ["lib", "priv", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Navin Peiris"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/navinpeiris/ex_unit_notifier"}]
  end
end

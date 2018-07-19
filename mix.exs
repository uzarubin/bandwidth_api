defmodule BandwidthApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bandwidth_api,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:xml_builder, "~> 2.0.0"},
      {:elixir_xml_to_map, "~> 0.1"},
    ]
  end

  def package do
    [
      maintainers: ["Ustin Zarubin", "Tomas Koci"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/uzarubin/bandwidth_api.git"
      }
    ]
  end
end

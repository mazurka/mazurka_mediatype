defmodule MazurkaMediatype.Mixfile do
  use Mix.Project

  def project do
    [app: :mazurka_mediatype,
     version: "0.1.3",
     elixir: "~> 1.0",
     description: "mazurka mediatype interface",
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:etude, ">= 0.1.0"}]
  end

  defp package do
    [files: ["lib", "mix.exs", "README*"],
     contributors: ["Cameron Bytheway"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/mazurka/mazurka_mediatype"}]
  end
end

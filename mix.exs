defmodule Micro.Mixfile do
  use Mix.Project

  def project do
    [app: :micro,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {Micro.Application, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      # Database wrapper and query generation.
      {:ecto, "~> 2.0"},
      {:postgrex, "~> 0.11"},

      # Web.
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:logster, "~> 0.4"},

      # JSON generation and Parsing.
      {:poison, "~> 3.1.0"},

      # Dates
      {:timex, "~> 3.0"},

      # Markdown to HTML conversion.
      {:cmark, "~> 0.7"},

      # Releases
      {:distillery, "~> 1.4"},

      # Tests
      {:faker, "~> 0.8", only: [:dev, :test]},

      # Development tools.
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:cortex, "~> 0.1", only: [:dev, :test]},
    ]
  end
end

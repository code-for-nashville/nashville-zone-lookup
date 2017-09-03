defmodule Parcel.Mixfile do
  use Mix.Project

  @assets_source "frontend"

  def project do
    [
      app: :parcel,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Parcel.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"}
    ]
  end

  defp aliases do
    [
      build_assets: &build_assets/1
    ]
  end

  defp build_assets(_) do
    Mix.shell.info("Building static assets in '#{@assets_source}'.")
    System.cmd("npm", ["install"], cd: "./#{@assets_source}")
    System.cmd("npm", ["run", "build"], cd: "./#{@assets_source}")

    Mix.shell.info("Static assets successfully built.")
  end
end

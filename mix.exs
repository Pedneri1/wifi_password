defmodule WifiPassword.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/Pedneri1/wifi_password"

  def project do
    [
      app: :wifi_password,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    "Gets the wifi password"
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end
end

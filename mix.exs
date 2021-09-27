defmodule TencentCloud.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/feng19/tencent_cloud"

  def project do
    [
      app: :tencent_cloud,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {TencentCloud.Application, []}
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.4"},
      {:finch, "~> 0.5"},
      {:jason, "~> 1.2"},
      {:tencent_cloud_core, "~> 0.1"},
      {:ex_doc, ">= 0.0.0", only: [:docs, :dev], runtime: false}
    ]
  end

  defp docs do
    [
      main: "TencentCloud",
      source_url: @source_url,
      formatters: ["html"]
    ]
  end

  defp package do
    [
      name: "tencent_cloud_core",
      description: "Common functions for TencentCloud",
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["feng19"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end
end

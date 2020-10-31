defmodule XmlParse.MixProject do
  use Mix.Project

  def project do
    [
      app: :xml_parse,
      version: "0.1.0",
      elixir: "~> 1.10",
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: [
        xmlparse_native: [mode: if(Mix.env() == :test, do: :debug, else: :release)]
      ],
      start_permanent: Mix.env() == :prod,
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
      {:benchee, "~> 1.0.1", only: :dev},
      {:sweet_xml, "~> 0.6.6"},
      {:rustler, "0.22.0-rc.0"},
      {:saxy, "~> 1.2.2"}
    ]
  end
end

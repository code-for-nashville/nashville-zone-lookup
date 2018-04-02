defmodule Mix.Tasks.Parcel.PrepareStaticAssets do
  use Mix.Task

  @shortdoc "Builds frontend assets and copies them to Phoenix app."

  @frontend "frontend"
  @assets "frontend/dist"

  def run(_args) do
    Mix.shell().info("Building static assets in '#{@frontend}'.")
    build_assets()
    Mix.shell().info("Static assets built successfully.")

    Mix.shell().info("Building a digest")
    Mix.Task.run("phx.digest", ["#{@assets}", "-o", "#{@assets}"])
    Mix.Task.run("phx.digest.clean", ["-o", "#{@assets}"])
    Mix.shell().info("Digest build successfully")
  end

  defp build_assets do
    {_, 0} = System.cmd("yarn", ["install"], cd: "./#{@frontend}")
    {_, 0} = System.cmd("yarn", ["run", "build"], cd: "./#{@frontend}")
  end

end

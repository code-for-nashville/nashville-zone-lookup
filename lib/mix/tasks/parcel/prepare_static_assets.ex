defmodule Mix.Tasks.Parcel.PrepareStaticAssets do
  use Mix.Task

  @shortdoc "Builds frontend assets and copies them to Phoenix app."

  @assets_source "frontend"
  @assets_target "priv/static"
  @asset_types ["css", "js"]
  @asset_types_with_source_maps ["css", "js"]

  def run(_args) do
    Mix.shell().info("Building static assets in '#{@assets_source}'.")
    build_assets()
    Mix.shell().info("Static assets built successfully.")

    Mix.shell().info("Copying static assets from '#{@assets_source}' to '#{@assets_target}'")
    copy_assets()
    Mix.shell().info("Static assets copied successfully.")
  end

  defp build_assets do
    {_, 0} = System.cmd("yarn", ["install"], cd: "./#{@assets_source}")
    {_, 0} = System.cmd("yarn", ["run", "build"], cd: "./#{@assets_source}")
  end

  defp copy_assets do
    @asset_types
    |> Enum.each(fn asset_type -> do_copy_assets(asset_type) end)
  end

  defp do_copy_assets(asset_type) when asset_type in @asset_types_with_source_maps do
    Mix.shell().info("Copying '#{asset_type}' static assets.")
    source_files = Path.wildcard("./#{@assets_source}/dist/static/#{asset_type}/*.#{asset_type}")
    map_files = Path.wildcard("./#{@assets_source}/dist/static/#{asset_type}/*.map")
    target_dir = "./#{@assets_target}/#{asset_type}"

    # Ensure the directory exists
    {_, 0} = System.cmd("mkdir", ["-p", target_dir])
    # Copy the files
    {_, 0} = System.cmd("cp", List.flatten([source_files, map_files, target_dir]))
  end
end

defmodule Mix.Tasks.Parcel.IngestLandUseTable do
  use Mix.Task

  @shortdoc "Ingest the Nashville land use spreadsheet"

  @land_use_table "./lib/mix/tasks/parcel/land_use_table_2017_02_28.xls.csv"

  def run(_args) do
    Mix.shell.info("Loading land use table...")

    lines = File.stream!(@land_use_table)
    |> CSV.decode!(strip_fields: true)
    |> Enum.to_list

    Mix.shell.info("Loaded #{length(lines)} lines")

    Mix.shell.info("Reading zone categories and their column ranges")

  end
end

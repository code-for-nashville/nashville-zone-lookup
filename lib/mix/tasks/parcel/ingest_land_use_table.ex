defmodule Mix.Tasks.Parcel.IngestLandUseTable do
  require CSV

  use Mix.Task

  @shortdoc "Ingest the Nashville land use spreadsheet"

  @land_use_table "./lib/mix/tasks/parcel/land_use_table_2017_02_28.xls.csv"

  # The input data is written such that not every zone gets it's own column
  #
  #  Ag   ,  RS280   , ...
  #  or   ,  thru   , ...
  #  Ag2  ,  RS3.75 , ...
  #
  # We want be able ot translate the group (e.g. "Ag or Ag2") into the
  # list of zones they include ("AG", "AR2a").
  @column_zones {
    # Blank
    [""],
    # "AG or AR2a"
    ["AG", "AR2a"],
    # "RS80 thru RS3.75-A"
    ["RS40", "RS30", "RS20", "RS15", "RS10", "RS7.5", "RS7.5-A", "RS5", "RS5-A", "RS3.75", "RS3.75-A"],
    # "R80 thru R6-A"
    ["R80", "R40", "R30", "R20", "R15", "R10", "R8", "R8-A", "R6", "R6-A"],
    # "RM2 thru RM20-A"
    ["RM2", "RM4", "RM6", "RM9", "RM9-A", "RM15", "RM15-A", "RM20", "RM20-A"],
    # "RM40 thru RM100-A"
    ["RM40", "RM40-A", "RM60", "RM60-A", "RM80-A", "RM100-A"],
    # "M H P"
    ["MHP"],
    # "* S P"
    ["SP"],
    # "MUN and MUN-A"
    ["MUN", "MUN-A"],
    # "MUL and MUL-A"
    ["MUL", "MUL-A"],
    # "MUG and MUG-A"
    ["MUG", "MUG-A"],
    # "MUI and MUI-A"
    ["MUI", "MUI-A"],
    # "O N"
    ["ON"],
    # "O L"
    ["OL"],
    # "O G"
    ["OG"],
    # "OR20 thru OR40-A"
    ["OR20", "OR20-A", "OR40", "OR40-A"],
    # "ORI and ORI-A"
    ["ORI", "ORI-A"],
    # "C N and CN-A"
    ["CN", "CN-A"],
    # "CL and CL-A"
    ["CL", "CL-A"],
    # "CS and CS-A"
    ["CS", "CS-A"],
    # "C A"
    ["CA"],
    # "C F"
    ["CF"],
    # "North"
    ["North"],
    # "South"
    ["South"],
    # "West"
    ["West"],
    # "Central"
    ["Central"],
    # "S C N"
    ["SCN"],
    # "S C C"
    ["SCC"],
    # "S C R"
    ["SCR"],
    # "I W D"
    ["IWD"],
    # "I R"
    ["IR"],
    # "I G"
    ["IG"]
  }

  def run(_args) do
    Mix.shell.info("Loading land use table...")

    lines = File.stream!(@land_use_table)
           |> CSV.decode!(strip_fields: true)
           |> Enum.to_list

    Mix.shell.info("Loaded #{length(lines)} lines")

    Mix.shell.info("Reconstructing zone groups...")

    zone_group_lines = Enum.slice(lines, 2..4)
    zone_groups = Stream.zip(zone_group_lines)
                 |> Stream.map(&Tuple.to_list/1)
                 |> Stream.map(fn(l) -> Enum.join(l, " ") end)
                 |> Enum.map(&String.trim/1)

    Mix.shell.info("Loaded #{length(zone_groups)} zone groups")

    Mix.shell.info("Reading zone categories and their column ranges")

  end
end

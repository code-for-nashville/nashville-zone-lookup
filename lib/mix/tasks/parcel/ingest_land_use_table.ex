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
  # We want be able ot translate the group (e.g. "Ag and Ag2") into the
  # list of zones they include ("AG", "AR2a").
  @zone_groups_to_zone_codes %{
    "AG and AR2a" => ["AG", "AR2a"],
    "RS80 thru RS3.75-A" => ["RS40", "RS30", "RS20", "RS15", "RS10", "RS7.5", "RS7.5-A", "RS5", "RS5-A", "RS3.75", "RS3.75-A"],
    "R80 thru R6-A" => ["R80", "R40", "R30", "R20", "R15", "R10", "R8", "R8-A", "R6", "R6-A"],
    "RM2 thru RM20-A" => ["RM2", "RM4", "RM6", "RM9", "RM9-A", "RM15", "RM15-A", "RM20", "RM20-A"],
    "RM40 thru RM100-A" => ["RM40", "RM40-A", "RM60", "RM60-A", "RM80-A", "RM100-A"],
    "M H P" => ["MHP"],
    "* S P" => ["SP"],
    "MUN and MUN-A" => ["MUN", "MUN-A"],
    "MUL and MUL-A" => ["MUL", "MUL-A"],
    "MUG and MUG-A" => ["MUG", "MUG-A"],
    "MUI and MUI-A" => ["MUI", "MUI-A"],
    "O N" => ["ON"],
    "O L" => ["OL"],
    "O G" => ["OG"],
    "OR 20 thru OR 40-A" => ["OR20", "OR20-A", "OR40", "OR40-A"],
    "ORI and ORI-A" => ["ORI", "ORI-A"],
    "C N and CN-A" => ["CN", "CN-A"],
    "CL and CL-A" => ["CL", "CL-A"],
    "CS and CS-A" => ["CS", "CS-A"],
    "C A" => ["CA"],
    "C F" => ["CF"],
    "North" => ["North"],
    "South" => ["South"],
    "West" => ["West"],
    "Central" => ["Central"],
    "S C N" => ["SCN"],
    "S C C" => ["SCC"],
    "S C R" => ["SCR"],
    "I W D" => ["IWD"],
    "I R" => ["IR"],
    "I G" => ["IG"]
  }

  def run(_) do
    Mix.shell.info "Loading land use table..."

    lines = File.stream!(@land_use_table)
    |> CSV.decode!(strip_fields: true)
    |> Enum.to_list

    Mix.shell.info "Loaded #{length(lines)} lines"

    Mix.shell.info "Reconstructing zone groups..."

    # Reconstruct the zone groups described in @zone_groups_to_zone_codes
    zone_group_lines = Enum.slice lines, 2..4
    ordered_zone_groups = Stream.zip(zone_group_lines)
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(fn(zone_group_parts) -> Enum.join(zone_group_parts, " ") end)
    |> Enum.map(&String.trim/1)

    Mix.shell.info "Loaded #{length(ordered_zone_groups)} zone groups"

    Mix.shell.info "Checking for unmapped zone groups..."

    # The first column in the current version is an empty string.
    # We keep it to simplify getting the column of each group, but
    # don't expect it to be mapped
    unmapped_zone_groups = (ordered_zone_groups -- [""]) -- Map.keys(@zone_groups_to_zone_codes)
    if length(unmapped_zone_groups) > 0 do
      Mix.shell.error(
        "Found #{length(unmapped_zone_groups)} unmapped zone groups: " <>
        "#{inspect unmapped_zone_groups}"
      )
      exit 1
    else
      Mix.shell.info "All zone groups are mapped (that's good!)"
    end

    Mix.shell.info "Mapping columns to zone codes..."

    column_zone_codes = Enum.map(
      ordered_zone_groups,
      &(@zone_groups_to_zone_codes[&1])
    )

    Mix.shell.info "Reading zone categories and their column ranges"

    zone_categories_line = Enum.at(lines, 1)

    # This row comes back
    #
    # "",  "Agricultural", "Residential", "", "", "", ...
    #
    # A category followed by empty strings indicates that thos columns
    # are included in the category.  This reduces our flat list into a
    # mapping of categoris to the columns they include. e.g.
    #
    # > map_to_columns(["",  "Agricultural", "Residential", "", "", ""])
    # %{"Agricultural": [1], "Residential": [2, 3, 4, 5]}
    #
    # This skips the irst columns with empty strings
    {zone_category_to_columns, _} = Stream.with_index(zone_categories_line)
    |> Enum.reduce(
      {
        # Categories to list of column indexes, e.g. %{"Residential" => [1, 2]}
        %{},
        # Until we get to our first non-empty name, skip empty strings
        :unset
      },
      fn({new_category, index}, {acc, current_category}) ->
        # We've got a new name, e.g. "Mixed Use". Create a new entry
        case new_category
        if new_category != "" do
          acc = Map.put(acc, new_category, [index])
          {acc, new_category}
        else
          # Add the index to the old entry, unless we haven't gotten to
          # our first non-empty name
          unless current_category == :unset do
            acc = %{acc | current_category => [index | acc[current_category]]}
          end
          {acc, current_category}
        end
      end
    )

    Mix.shell.info "Zone categories: #{ inspect zone_category_to_columns}"

  end
end
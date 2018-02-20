defmodule Mix.Tasks.Parcel.IngestLandUseTable do
  use Mix.Task

  @shortdoc "Transform the Nashville.gov land use spreadsheet into a list of zone land use conditions"

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

  def run(args) do
    {opts, [filepath]} = OptionParser.parse!(
      args,
      strict: [verbose: :boolean]
    )
    verbose = Keyword.get(opts, :verbose, false)

    shell = case verbose do
      true -> Mix.Shell.IO
      false -> Mix.Shell.Quiet
    end

    shell.info "Loading land use table..."

    lines = File.stream!(filepath)
    |> CSV.decode!(strip_fields: true)
    |> Enum.to_list

    shell.info "Loaded #{length(lines)} lines"

    shell.info "Reconstructing zone groups..."

    ordered_zone_groups = get_zone_groups lines

    shell.info "Loaded #{length(ordered_zone_groups)} zone groups"

    shell.info "Checking for unmapped zone groups..."

    unmapped_zone_groups = get_unmapped_zone_groups ordered_zone_groups
    if length(unmapped_zone_groups) > 0 do
      shell.error(
        "Found #{length(unmapped_zone_groups)} unmapped zone groups: " <>
        "#{inspect unmapped_zone_groups}"
      )
      exit 1
    else
      shell.info "All zone groups are mapped (that's good!)"
    end

    shell.info "Mapping columns to zone codes..."

    column_zone_codes = Enum.map(
      ordered_zone_groups,
      &(@zone_groups_to_zone_codes[&1])
    )

    shell.info "Reading zone categories and their column ranges"

    zone_category_to_columns = sparsify_unique(Enum.at(lines, 1))

    shell.info "Zone categories: #{ inspect zone_category_to_columns}"

    shell.info "Generating zone land use conditions..."

    land_use_condition_lines = Enum.slice(lines, 5..-1)
    |> Stream.filter(&(not land_use_category?(&1)))

    zone_land_use_conditions = Enum.flat_map(
      land_use_condition_lines,
      &(get_zoning_district_land_use_conditions(&1, column_zone_codes))
    )

    shell.info(
      "Generated #{length(zone_land_use_conditions)} zone land use conditions"
    )

    zone_land_use_conditions
  end

  @doc ~S"""
  Reconstruct the zone groups described in @zone_groups_to_zone_codes.

  The input data is written such that not every zone gets it's own column.
  Rows at index 2 through 4 include identifiers of groups of zones:

    ,          ,....
    Agriculture, Residential,....
    AG   ,  RS280   , ...
    and   , thru   , ...
    AR2a  , RS3.75 , ...

  We translate these three lines into a single list of groups, e.g.
  ["AG and AR2a", "RS280 thru RS3.75"].  This can be used with
  @zone_groups_to_zone_codes to translate the table into information per
  zone code, even though we only receive information per zone group.

  Note that these come back preserving the order of the columns they are in.

  ## Examples
  A basic example:

      iex> Mix.Tasks.Parcel.IngestLandUseTable.get_zone_groups([
      ...>   ["Ignore", "these"],
      ...>   ["First", "two", "rows"],
      ...>   ["AG", "RS80"],
      ...>   ["and", "thru"],
      ...>   ["AR2a", "RS3.75-A"]
      ...> ])
      ["AG and AR2a", "RS80 thru RS3.75-A"]

  This also handles stripping whitespace - sometimes identifiers only take
  up two lines

      iex> Mix.Tasks.Parcel.IngestLandUseTable.get_zone_groups([
      ...>   ["Ignore", "these"],
      ...>   ["two", "rows"],
      ...>   ["M", ""],
      ...>   ["H", "O"],
      ...>   ["P", "N"]
      ...> ])
      ["M H P", "O N"]
  """
  def get_zone_groups(lines) do
    zone_group_lines = Enum.slice lines, 2..4

    Stream.zip(zone_group_lines)
      |> Stream.map(&Tuple.to_list/1)
      |> Stream.map(fn(zone_group_parts) -> Enum.join(zone_group_parts, " ") end)
      |> Enum.map(&String.trim/1)
  end

  @doc ~S"""
  Returns a list of zone groups that we haven't mapped to individual zone codes

  ## Example

  Returns anything we haven't mapped in @zone_groups_to_zone_codes

      iex> Mix.Tasks.Parcel.IngestLandUseTable.get_unmapped_zone_groups([
      ...> "GO",  # not real
      ...> "PREDS" ,  # not real
      ...> "O N"  # real
      ...> ])
      ["GO", "PREDS"]

  This ignores the special case of an empty string (""). Right now we leave in
  the empty string as the first item to preserve the column index of the zone
  groups.

      iex> Mix.Tasks.Parcel.IngestLandUseTable.get_unmapped_zone_groups([
      ...>  "WINGARDIUM",
      ...>  "LEVIOSA",
      ...>  ""   # ignored
      ...> ])
      ["WINGARDIUM", "LEVIOSA"]
  """
  def get_unmapped_zone_groups(zone_groups) do
    actualy_zone_groups = zone_groups -- [""]

    actualy_zone_groups -- Map.keys(@zone_groups_to_zone_codes)
  end

  @doc ~S"""
  Transform a list of unique values into a mapping of the value to the columns it covers

  This is a hacky-ish function to get the ranges of columns covered by the
  zone categories in our table. One of the headers of the table is

    "",  "Agricultural", "Residential", "", "", "", ...

  Each non-empty string is a category, the empty strings after the category
  indicate that the category applies for the following columns.  This
  transforms this into a mapping of each unique value (really just our category)
  to a list of the columns it covers.

  This is useful as an intermediate step to add a "zone_category" field
  to our Zone structs.  Because we expand the zone groups in the actual
  headers into individual zone codes, we can use the result of this
  function.

  ## Example

  In the basic case this maps each name to the column range:

      iex> Mix.Tasks.Parcel.IngestLandUseTable.sparsify_unique([
      ...>   "a",
      ...>   "",
      ...>   "",
      ...>   "b",
      ...>   "c"
      ...> ])
      %{"a" => [2, 1, 0], "b" => [3], "c" => [4]}

  If the first elements are the empty value, it treats the empty value as
  it's own unique value, then continues compressing after the first non-unique
  value

      iex> Mix.Tasks.Parcel.IngestLandUseTable.sparsify_unique([
      ...>   "",
      ...>   "",
      ...>   "a",
      ...>   "",
      ...>   "b"
      ...> ])
      %{"" => [1, 0], "a" => [3, 2], "b" => [4]}
  """
  def sparsify_unique(list, empty \\ "") do
    {sparsified, _} = Stream.with_index(list)
    |> Enum.reduce(
      {
        %{}, # Accumulator, e.g. %{"Residential" => [2, 1]}
        nil
      },
      fn({new_category, index}, {acc, current_category}) ->
        case {new_category, current_category} do
          {^empty, current_category} when current_category != nil ->
            # Add the index to the old entry
            acc = %{acc | current_category => [index | acc[current_category]]}
            {acc, current_category}
          # We've got a new name, e.g. "Mixed Use". Create a new entry
          {new_category, _} ->
            acc = Map.put(acc, new_category, [index])
            {acc, new_category}
        end
      end
    )
    sparsified
  end

  @doc ~S"""
  Returns True if the line represents a land use category

  Land use category lines have one entry in the first column - every other
  entry is blank.

    Residential Uses, "", "", "", "", ...
    Single-family, P, P, PC, ...

  ## Example

  This only returns true if the first element is populated and the remaining
  lines are blank:

      iex> Mix.Tasks.Parcel.IngestLandUseTable.land_use_category?(
      ...>   ["hello", "", "", "", ""]
      ...> )
      true

  If the first line is empty, or there are some non-empty strings, this
  returns false

      iex> Mix.Tasks.Parcel.IngestLandUseTable.land_use_category?(
      ...>   ["", "hello", "", "", "", ""]
      ...> )
      false

      iex> Mix.Tasks.Parcel.IngestLandUseTable.land_use_category?(
      ...>   ["hello", "", "", "", "", "world"]
      ...> )
      false
  """
  def land_use_category?(line) when length(line) > 0 do
    [category | rest ] = line
    (
      category != "" and
      Enum.all?(rest, &(&1 == ""))
    )
  end

  @doc ~S"""
  Return a list of `Parcel.Domain.ZoningDistrictLandUseCondition` for the line

  A `line` should comes in the format

    "Manufacturing, light", "A", "P", "", "PC", ...

  and the `column_zone_codes` include a list of Zoning District codes covered
  for each column (with the first blank):

    [nil, ["AG, "AR2a"], ["SP"], ...]

  ## Example

  The result is a flat list of `Parcel.Domain.ZoningDistrictLandUseCondition`.
  Empty condition codes are translated to "NP" (Not permitted).

      iex> Mix.Tasks.Parcel.IngestLandUseTable.get_zoning_district_land_use_conditions(
      ...>   ["Microbrewery", "A", "P", "", "PC"],
      ...>   [nil, ["North", "South"], ["West"], ["MUL", "MUL-A", "ON"], ["OL"]]
      ...> )
      [
        %Parcel.Domain.ZoningDistrictLandUseCondition{zoning_district: "North", land_use: "Microbrewery", land_use_condition: "A"},
        %Parcel.Domain.ZoningDistrictLandUseCondition{zoning_district: "South", land_use: "Microbrewery", land_use_condition: "A"},
        %Parcel.Domain.ZoningDistrictLandUseCondition{zoning_district: "West", land_use: "Microbrewery", land_use_condition: "P"},
        %Parcel.Domain.ZoningDistrictLandUseCondition{zoning_district: "MUL", land_use: "Microbrewery", land_use_condition: "NP"},
        %Parcel.Domain.ZoningDistrictLandUseCondition{zoning_district: "MUL-A", land_use: "Microbrewery", land_use_condition: "NP"},
        %Parcel.Domain.ZoningDistrictLandUseCondition{zoning_district: "ON", land_use: "Microbrewery", land_use_condition: "NP"},
        %Parcel.Domain.ZoningDistrictLandUseCondition{zoning_district: "OL", land_use: "Microbrewery", land_use_condition: "PC"}
      ]
  """
  def get_zoning_district_land_use_conditions(line, columns_zone_codes) do
    alias Parcel.Domain.ZoningDistrictLandUseCondition, as: ZoningCondition

    [land_use | condition_codes ] = line
    [_ | columns_zone_codes ] = columns_zone_codes

    Stream.zip(condition_codes, columns_zone_codes)
    |> Enum.flat_map(fn {condition_code, column_zone_codes} ->
      condition_code = case condition_code do
        "" -> "NP"
        _ -> condition_code
      end
      # TODO: The field values should actually be objects but hacking it for now
      Enum.map(
        column_zone_codes, fn zone_code ->
          %ZoningCondition{
            land_use: land_use,
            land_use_condition: condition_code,
            zoning_district: zone_code,
          }
        end)
    end)
  end
end

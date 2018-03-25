defmodule Mix.Tasks.Parcel.IngestLandUseTable do
  @moduledoc ~S"""
  Ingest the Nashville land use table as a CSV

  This translates a table of zoning code land use conditions provided by
  Nashville into a list of `ZoneLandUseCondition`s.
  In the future this will write to a file or database, but for now it
  just returns the data as a list.

  A version of the Nashville land use table can be downloaded as a CSV from
  https://docs.google.com/spreadsheets/d/1O0Qc8nErSbstCiWpbpRQ0tPMS0NukCmcov2-s_u8Umg/
  This spreadsheet has a peculiar format described in detail in the source code
  of this task.
  """

  use Mix.Task
  alias Parcel.Repo
  alias Parcel.Zoning.{LandUse, Zone, ZoneLandUseCondition}

  @shortdoc "Ingest the Nashville land use table as a CSV"

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
    "RS80 thru RS3.75-A" => [
      "RS80",
      "RS40",
      "RS30",
      "RS20",
      "RS15",
      "RS10",
      "RS7.5",
      "RS7.5-A",
      "RS5",
      "RS5-A",
      "RS3.75",
      "RS3.75-A"
    ],
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
    {opts, [filepath]} =
      OptionParser.parse!(
        args,
        strict: [verbose: :boolean]
      )

    verbose = Keyword.get(opts, :verbose, false)

    shell =
      case verbose do
        true -> Mix.Shell.IO
        false -> Mix.Shell.Quiet
      end

    shell.info("Starting app...")

    Mix.Task.run("app.start")

    shell.info("Loading land use table...")

    lines =
      File.stream!(filepath)
      |> CSV.decode!(strip_fields: true)
      |> Enum.to_list()

    {headers, data} = Enum.split(lines, 5)

    shell.info("Loaded #{length(lines)} lines")

    shell.info("Reconstructing zone groups...")

    ordered_zone_groups = get_zone_groups(headers)

    shell.info("Loaded #{length(ordered_zone_groups)} zone groups")

    shell.info("Checking for unmapped zone groups...")

    unmapped_zone_groups = get_unmapped_zone_groups(ordered_zone_groups)

    if length(unmapped_zone_groups) > 0 do
      shell.error(
        "Found #{length(unmapped_zone_groups)} unmapped zone groups: " <>
          "#{inspect(unmapped_zone_groups)}"
      )

      exit(1)
    else
      shell.info("All zone groups are mapped (that's good!)")
    end

    shell.info("Mapping columns to zone codes...")

    column_zone_codes =
      Enum.map(
        ordered_zone_groups,
        &@zone_groups_to_zone_codes[&1]
      )

    shell.info("Generating zone land use conditions...")

    land_uses = get_land_uses(data)

    land_uses =
      Enum.map(
        land_uses,
        &LandUse.changeset(%LandUse{}, &1)
      )
      |> Enum.map(&Repo.insert!(&1, on_conflict: :replace_all, conflict_target: :name))

    land_uses_by_name =
      Enum.reduce(
        land_uses,
        %{},
        &Map.put(&2, &1.name, &1)
      )

    zones_by_code =
      Enum.reduce(
        Repo.all(Zone),
        %{},
        &Map.put(&2, &1.code, &1)
      )

    zone_land_use_conditions =
      Enum.filter(
        data,
        &is_nil(land_use_category(&1))
      )
      |> Enum.flat_map(
        &get_zone_land_use_conditions(
          &1,
          column_zone_codes,
          land_uses_by_name,
          zones_by_code
        )
      )

    zone_land_use_conditions =
      Enum.map(
        zone_land_use_conditions,
        &ZoneLandUseCondition.changeset(%ZoneLandUseCondition{}, &1)
      )
      |> Enum.map(
        &Repo.insert!(
          &1,
          on_conflict: :replace_all,
          conflict_target: [:zone_id, :land_use_id]
        )
      )

    shell.info("Generated #{length(zone_land_use_conditions)} zone land use conditions")

    zone_land_use_conditions
  end

  @doc ~S"""
  Reconstruct the zone groups described in @zone_groups_to_zone_codes.

  The input data is written such that not every zone gets it's own column.
  Rows at index 2 through 4 include identifiers of groups of zones:

    ,          ,....
    ,Agriculture, Residential,....
    ,AG   ,  RS280   , ...
    ,and   , thru   , ...
    ,AR2a  , RS3.75 , ...

  We translate these three lines into a single list of groups, e.g.
  ["AG and AR2a", "RS280 thru RS3.75"].  This can be used with
  @zone_groups_to_zone_codes to translate the table into information per
  zone code, even though we only receive information per zone group.

  Note that these come back preserving the order of the columns they are in,
  except that they are offset one to the left.  The first column in the table
  doesn't contain useful zone group information and is dropped.

  ## Examples
  A basic example that ignores the first column and joins the data predictably:

      iex> Mix.Tasks.Parcel.IngestLandUseTable.get_zone_groups([
      ...>   ["Ignore", "all", "these"],
      ...>   ["First", "two", "rows"],
      ...>   ["", "AG", "RS80"],
      ...>   ["", "and", "thru"],
      ...>   ["", "AR2a", "RS3.75-A"]
      ...> ])
      ["AG and AR2a", "RS80 thru RS3.75-A"]

  This also handles stripping whitespace - sometimes identifiers only take
  up two lines

      iex> Mix.Tasks.Parcel.IngestLandUseTable.get_zone_groups([
      ...>   ["Ignore", "all", "these"],
      ...>   ["first", "two", "rows"],
      ...>   ["", "M", ""],
      ...>   ["", "H", "O"],
      ...>   ["", "P", "N"]
      ...> ])
      ["M H P", "O N"]
  """
  def get_zone_groups(headers) do
    zone_group_headers = Enum.slice(headers, 2..4)

    Stream.zip(zone_group_headers)
    |> Stream.drop(1)
    |> Stream.map(&Tuple.to_list/1)
    |> Stream.map(fn zone_group_parts -> Enum.join(zone_group_parts, " ") end)
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
  """
  def get_unmapped_zone_groups(zone_groups) do
    actualy_zone_groups = zone_groups

    actualy_zone_groups -- Map.keys(@zone_groups_to_zone_codes)
  end

  @doc ~S"""
  Returns the land use category if the line represents one, otherwise nil

  Land use category lines have one entry in the first column - every other
  entry is blank.

    Residential Uses, "", "", "", "", ...
    Single-family, P, P, PC, ...

  ## Example

  This only returns a category if the first element is populated and the
  remaining lines are blank. It also strips out the trailing "Hello":

      iex> Mix.Tasks.Parcel.IngestLandUseTable.land_use_category(
      ...>   ["Industrial Uses", "", "", "", ""]
      ...> )
      "Industrial"

  If the first line is empty, there are some non-empty strings, or the
  land use category doesn't end in " Uses", this returns nil

      iex> Mix.Tasks.Parcel.IngestLandUseTable.land_use_category(
      ...>   ["", "Industrial Uses", "", "", "", ""]
      ...> )
      nil

      iex> Mix.Tasks.Parcel.IngestLandUseTable.land_use_category(
      ...>   ["Residential Uses", "", "", "", "", "world"]
      ...> )
      nil
  """
  def land_use_category(line) when length(line) > 0 do
    [category | rest] = line

    if category != "" and String.ends_with?(category, " Uses") and Enum.all?(rest, &(&1 == "")) do
      String.replace(category, " Uses", "")
    else
      nil
    end
  end

  @doc ~S"""
  Reduce a list of input lines into LandUse-like maps, with categories.

  A `line` should come in the format

    "Manufacturing, light", "A", "P", "", "PC", ...

  or be a land use category line, as described in `land_use_category`.

  ## Example

      iex> IngestLandUseTable.get_land_uses([
      ...>   ["Residential Uses", "", "", "", ""],
      ...>   ["Garage Sale", "A", "P", "", "PC"],
      ...>   ["Institutional Uses", "", "", "", ""],
      ...>   ["Orphanage", "A", "P", "", ""],
      ...>   ["Monastery or convent", "P", "P", "", ""],
      ...> ])
      [
        %{category: "Residential", "name": "Garage Sale"},
        %{category: "Institutional", "name": "Orphanage"},
        %{category: "Institutional", "name": "Monastery or convent"},
      ]
  """
  def get_land_uses(lines) do
    {land_uses, _} =
      Enum.reduce(lines, {[], nil}, fn line, {land_uses, category} ->
        case land_use_category(line) do
          nil ->
            [name | _] = line

            {
              land_uses ++
                [
                  %{category: category, name: name}
                ],
              category
            }

          category ->
            {land_uses, category}
        end
      end)

    land_uses
  end

  @doc ~S"""
  Return a list of `ZoneLandUseCondition`-like maps for the line

  A `line` should comes in the format

    "Manufacturing, light", "A", "P", "", "PC", ...

  and the `column_zone_codes` include a list of Zone codes covered
  for each column:

    [["AG, "AR2a"], ["SP"], ...]

  ## Example

  The result is a flat list of `ZoneLandUseCondition`-like maps.
  Empty condition codes are translated to "NP" (Not permitted).

      iex> Mix.Tasks.Parcel.IngestLandUseTable.get_zone_land_use_conditions(
      ...>   ["Microbrewery", "A", "P", "", "PC"],
      ...>   [["North", "South"], ["West"], [ "ON"], ["OL"]],
      ...>   %{"Microbrewery" => %LandUse{id: 1, name: "Microbrewery", category: "Industrial"}},
      ...>   %{
      ...>    "North" => %Zone{id: 1, code: "North"},
      ...>    "South" => %Zone{id: 2, code: "South"},
      ...>    "West" => %Zone{id: 3, code: "West"},
      ...>    "ON" => %Zone{id: 4, code: "ON"},
      ...>    "OL" => %Zone{id: 5, code: "OL"},
      ...>   }
      ...> )
      [
        %{zone_id: 1, land_use_id: 1, land_use_condition_id: LandUseCondition.a().id},
        %{zone_id: 2, land_use_id: 1, land_use_condition_id: LandUseCondition.a().id},
        %{zone_id: 3, land_use_id: 1, land_use_condition_id: LandUseCondition.p().id},
        %{zone_id: 4, land_use_id: 1, land_use_condition_id: LandUseCondition.np().id},
        %{zone_id: 5, land_use_id: 1, land_use_condition_id: LandUseCondition.pc().id}
      ]
  """
  def get_zone_land_use_conditions(
        line,
        columns_zone_codes,
        land_uses_by_name,
        zones_by_code
      ) do
    alias Parcel.Zoning.LandUseCondition

    [land_use | condition_codes] = line

    Stream.zip(condition_codes, columns_zone_codes)
    |> Enum.flat_map(fn {condition_code, column_zone_codes} ->
      condition_code =
        case condition_code do
          "" -> "NP"
          _ -> condition_code
        end

      Enum.map(column_zone_codes, fn zone_code ->
        %{
          land_use_id: land_uses_by_name[land_use].id,
          land_use_condition_id: LandUseCondition.land_use_condition_for_code(condition_code).id,
          zone_id: zones_by_code[zone_code].id
        }
      end)
    end)
  end
end

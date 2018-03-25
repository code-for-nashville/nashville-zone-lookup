defmodule Parcel.Zoning.ZoningDistrictLandUseCondition do
  @moduledoc ~S"""
  The `Parcel.Domain.LandUseCondition` under which a `Parcel.Domain.LandUse`
  can be performed in a `Parcel.Domain.ZoningDistrict`.

  Only one `Parcel.Domain.LandUseCondition` should be defined for each
  `Parcel.Domain.LandUse`/`Parcel.Domain.ZoningDistrict` pair.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Parcel.Repo
  alias Parcel.Zoning.{LandUse, LandUseCondition, ZoningDistrict, ZoningDistrictLandUseCondition}

  @nashville_arc_gis_api Application.get_env(:parcel, :nashville_arc_gis_api)

  schema "zoning_district_land_use_conditions" do
    belongs_to(:land_use, LandUse)
    belongs_to(:land_use_condition, LandUseCondition)
    belongs_to(:zoning_district, ZoningDistrict)

    timestamps()
  end

  @doc false
  def changeset(%ZoningDistrictLandUseCondition{} = zoning_district_land_use_condition, attrs) do
    zoning_district_land_use_condition
    |> cast(attrs, [:land_use_id, :land_use_condition_id, :zoning_district_id])
    |> validate_required([:land_use_id, :land_use_condition_id, :zoning_district_id])
    |> unique_constraint(
      :zoning_district,
      name: :zoning_district_land_use_conditions_zoning_district_id_land_use
    )
  end

  @doc """
  Returns an object representing the land use for a geographic point.
  """
  def land_use_summary(address) do
    import Ecto.Query

    {:ok, point} = @nashville_arc_gis_api.geocode_address(address)
    {:ok, zone_code} = @nashville_arc_gis_api.get_zone(point)

    # All land uses conditions where zoning_district.code = zone_code
    zone_land_uses = from zone_land_use in ZoningDistrictLandUseCondition,
      join: zone in ZoningDistrict, where: zone.id == zone_land_use.zoning_district_id,
      where: zone.code == ^zone_code,
      preload: [:land_use, :land_use_condition]

    zone = Repo.get_by!(ZoningDistrict, code: zone_code)

    %{
      "zone" => %{
        "code" => zone.code,
        "description" => zone.description,
        "category" => zone.category,
      },
      "land_uses" => Enum.map(
        Repo.all(zone_land_uses),
        fn(zone_land_use) -> %{
          "category" => zone_land_use.land_use.category,
          "name" => zone_land_use.land_use.name,
          "condition" => %{
            "code" => zone_land_use.land_use_condition.code,
            "category" => zone_land_use.land_use_condition.category,
            "description" => zone_land_use.land_use_condition.description,
            "info_link" => zone_land_use.land_use_condition.info_link,
          }
        }end
      )
    }
  end
end

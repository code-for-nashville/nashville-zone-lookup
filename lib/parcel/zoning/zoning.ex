defmodule Parcel.Zoning do
  @moduledoc """
  Find the land use for a given address
  """
  alias Parcel.Repo
  alias Parcel.Zoning.{ZoningDistrict, ZoningDistrictLandUseCondition}
  @nashville_arc_gis_api Application.get_env(:parcel, :nashville_arc_gis_api)

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

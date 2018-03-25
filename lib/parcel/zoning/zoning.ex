defmodule Parcel.Zoning do
  @moduledoc """
  Find the land use for a given address
  """

  @nashville_arc_gis_api Application.get_env(:parcel, :nashville_arc_gis_api)

  @doc """
  Returns an object representing the land use for a geographic point.
  """
  def land_use_summary(address) do
    {:ok, point} = @nashville_arc_gis_api.geocode_address(address)
    {:ok, zone_code} = @nashville_arc_gis_api.get_zone(point)

    %{
      zone_code: zone_code,
      land_uses: []
    }
  end
end

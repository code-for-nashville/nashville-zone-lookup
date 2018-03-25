defmodule ParcelWeb.LandUsesController do
  use ParcelWeb, :controller
  alias Parcel.Zoning.ZoningDistrictLandUseCondition

  action_fallback(ParcelWeb.FallbackController)

  def index(conn, %{"address" => address}) do
    json(conn, ZoningDistrictLandUseCondition.land_use_summary(address))
  end

  def index(_conn, _params), do: {:error, :bad_request, "Missing address parameter."}
end

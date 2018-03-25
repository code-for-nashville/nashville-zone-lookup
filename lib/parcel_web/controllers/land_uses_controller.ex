defmodule ParcelWeb.LandUsesController do
  use ParcelWeb, :controller
  alias Parcel.Zoning

  action_fallback(ParcelWeb.FallbackController)

  def index(conn, %{"address" => address}) do
    json(conn, Zoning.land_use_summary(address))
  end

  def index(_conn, _params), do: {:error, :bad_request, "Missing address parameter."}
end

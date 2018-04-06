defmodule ParcelWeb.LandUsesController do
  use ParcelWeb, :controller
  alias Parcel.Zoning.ZoneLandUseCondition

  action_fallback(ParcelWeb.FallbackController)

  def index(conn, %{"address" => address}) do
    case ZoneLandUseCondition.land_use_summary(address) do
      {:ok, land_use_summary} -> json(conn, land_use_summary)
      # Address not found
      :not_found -> put_status(conn, 404)
      # The Zone represents an unknown zone or sattelite city
      :unknown_zone -> put_status(conn, 422)
      # A random error
      :error -> put_status(conn, 500)
    end
  end

  def index(_conn, _params), do: {:error, :bad_request, "Missing address parameter."}
end

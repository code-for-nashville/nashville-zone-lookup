defmodule NashvilleZoneLookupWeb.LandUsesController do
  use NashvilleZoneLookupWeb, :controller
  alias NashvilleZoneLookup.Zoning.ZoneLandUseCondition

  action_fallback(NashvilleZoneLookupWeb.FallbackController)

  def index(conn, %{"address" => address}) do
    case ZoneLandUseCondition.land_use_summary(address) do
      {:ok, land_use_summary} -> json(conn, land_use_summary)
      # Address not found
      :not_found -> put_status(conn, 404) |> json(%{message: "We couldn't find an address matching \"#{address}\"."})
      # The Zone represents an unknown zone or sattelite city
      :unknown_zone -> put_status(conn, 422) |> json(%{message: "We don't have zoning information available for \"#{address}\"."})
      # A random error
      :error -> put_status(conn, 500) |> json(%{message: "Unknown server error - please try again later."})
    end
  end

  def index(_conn, _params), do: {:error, :bad_request, "Missing address parameter."}
end

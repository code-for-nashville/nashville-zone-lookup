defmodule Parcel.NashvilleMetroApi.ArcgisApi.HttpClient do
  @behaviour Parcel.NashvilleMetroApi.ArcgisApi.Client

  alias Parcel.NashvilleMetroApi.ArcgisApi

  require Logger

  @impl true
  def get_parcel_ownership_data({x, y}) do
    Logger.info("Requesting parcel ownership data for coordinates (x, y) (#{x}, #{y}).")

    geometry_json = Poison.encode!(%{"x" => x, "y" => y})

    query_params = [
      {"geometry", geometry_json},
      # TODO: make the remaining query params not so magic later
      {"f", "json"},
      {"returnGeometry", true},
      {"spatialRel", "esriSpatialRelIntersects"},
      {"geometryType", "esriGeometryPoint"},
      # probably not constant, seems to wkid from other responses
      {"inSR", 102100},
      {"outFields", "*"},
      # same as inSR
      {"outSR", 102100}
    ]

    case ArcgisApi.get("/Cadastral/Cadastral_Layers/MapServer/4/query", [], params: query_params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Logger.info("Successful request.")
        {:ok, body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("The request failed due to the following error: #{reason}.")
        :error
    end
  end
end

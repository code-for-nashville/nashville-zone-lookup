defmodule NashvilleZoneLookup.NashvilleArcgisApi.HttpClient do
  @behaviour NashvilleZoneLookup.NashvilleArcgisApi.Client

  alias NashvilleZoneLookup.NashvilleArcgisApi

  @impl true
  def geocode_address(address) do
    endpoint = "/Locators/LocNashComp/GeocodeServer/findAddressCandidates"

    # For a full list of available query parameters, see:
    # https://developers.arcgis.com/rest/geocode/api-reference/geocoding-find-address-candidates.htm
    query_params = [
      # Address to search for candidates for
      {"SingleLine", address},
      # We only care about the first candidate
      {"maxLocations", 1}
    ]

    case NashvilleArcgisApi.get(endpoint, [], params: query_params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        address_match = List.first(body["candidates"])

        if not is_nil(address_match) do
          point_map = address_match["location"]
          {:ok, {point_map["x"], point_map["y"]}}
        else
          {:not_found, "No candidates returned"}
        end

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Error #{reason}"}
    end
  end

  @impl true
  def get_zone({x, y}) do
    zoning_landuse_layer_id = 14
    endpoint = "/Zoning_Landuse/Zoning/MapServer/#{zoning_landuse_layer_id}/query"
    geometry_json = Poison.encode!(%{"x" => x, "y" => y})

    # For a description of these parameters, see the MapService/query API docs:
    # https://developers.arcgis.com/rest/services-reference/query-map-service-layer-.htm#GUID-BF585125-FCA5-425C-B1AA-670E870619D0
    query_params = [
      {"geometry", geometry_json},
      {"geometryType", "esriGeometryPoint"},
      # Skip returning the Zone polygon - we're just using the ZONE_DESC right now
      {"returnGeometry", false},
      # Minimal output
      {"outFields", "ZONE_DESC"}
    ]

    case NashvilleArcgisApi.get(endpoint, [], params: query_params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        result = List.first(body["features"])
        {:ok, result["attributes"]["ZONE_DESC"]}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Server error #{reason}"}
    end
  end
end

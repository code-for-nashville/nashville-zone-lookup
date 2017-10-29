defmodule Parcel.NashvilleMetroApi.AddressCandidatesApi do
  use HTTPoison.Base

  @base_url "http://maps.nashville.gov/arcgis/rest/services/Locators/LocNashComp/GeocodeServer"
  @default_headers [{"Accept", "application/json"}]
  @max_locations Application.get_env(:parcel, __MODULE__)[:max_locations]

  @doc false
  def process_url(url), do: @base_url <> url

  @doc false
  def process_request_headers(headers), do: @default_headers ++ headers

  @doc false
  def process_response_body(body), do: Poison.decode!(body)
end

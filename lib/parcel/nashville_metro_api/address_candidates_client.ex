defmodule Parcel.NashvilleMetroApi.AddressCandidatesClient do
  use HTTPoison.Base

  @base_url "http://maps.nashville.gov/arcgis/rest/services/Locators/LocNashComp/GeocodeServer"
  @default_headers [{"Accept", "application/json"}]
  @max_locations Application.get_env(:parcel, __MODULE__)[:max_locations]

  @doc false
  def process_url(url), do: @base_url <> url

  @doc false
  def process_response_body(body), do: Poison.decode!(body)

  @doc """
  Fetches canonical address candidates for a given address.
  """
  def find_address_candidates(address) do
    query_params = [
      {"SingleLine", address},         # address to search for candidates for
      {"f", "json"},                   # response in JSON format
      {"maxLocations", @max_locations} # number of candidates to return
    ]

    __MODULE__.get("/findAddressCandidates", @default_headers, params: query_params)
  end
end

defmodule NashvilleZoneLookup.NashvilleArcgisApi do
  @moduledoc """
  A minimal JSON API client for the Nashville Metro ArgGIS Enterprise server

  For general information on the ArcGIS REST API, see
  https://developers.arcgis.com/documentation/core-concepts/rest-api/. Services
  are devided up into broad chunks of functionality.

  Navigating to the @base_url in the browser lets you manually explore
  available endpoints within the Nashville ArcGIS deployment.
  """
  use HTTPoison.Base

  @base_url "http://maps.nashville.gov/arcgis/rest/services"
  @default_headers [{"Accept", "application/json"}]

  @web_mercator_wkid 3857
  @default_params [
    {"f", "json"},
    {"outSR", @web_mercator_wkid},
    {"inSR", @web_mercator_wkid}
  ]

  @doc false
  def process_url(url), do: @base_url <> url

  @doc false
  def process_request_headers(headers), do: @default_headers ++ headers

  @doc """
  Request JSON and sets the spatial reference to Web Mercator for consistency
  """
  def process_request_options(options) do
    Keyword.update(options, :params, @default_params, &(@default_params ++ &1))
  end

  @doc false
  def process_response_body(body), do: Poison.decode!(body)
end

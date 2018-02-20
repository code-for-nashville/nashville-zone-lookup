defmodule Parcel.NashvilleMetroApi.AddressCandidatesApi.HttpClient do
  @behaviour Parcel.NashvilleMetroApi.AddressCandidatesApi.Client

  alias Parcel.NashvilleMetroApi.AddressCandidatesApi

  require Logger

  @max_locations Application.get_env(:parcel, __MODULE__)[:max_locations]

  @impl true
  def find_address_candidates(address) do
    Logger.info("Requesting address candidates for #{address}.")

    query_params = [
      {"SingleLine", address},         # address to search for candidates for
      {"f", "json"},                   # response in JSON format
      {"maxLocations", @max_locations} # number of candidates to return
    ]

    case AddressCandidatesApi.get("/findAddressCandidates", [], params: query_params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Logger.info("Successful request.")
        {:ok, body["candidates"]}
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("The request failed due to the following error: #{reason}.")
        :error
    end
  end
end

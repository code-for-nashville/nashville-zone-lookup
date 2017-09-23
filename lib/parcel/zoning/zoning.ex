defmodule Parcel.Zoning do
  @moduledoc """
  The Zoning context.
  """

  alias Parcel.NashvilleMetroApi.AddressCandidatesClient
  alias Parcel.Zoning.AddressCandidate
  alias HTTPoison.Error
  alias HTTPoison.Response

  @doc """
  Returns the list of address candidates sorted by score in descending order.
  """
  def list_address_candidates(address) do
    with {:ok, %Response{status_code: 200, body: body}} <- AddressCandidatesClient.find_address_candidates(address)
    do
      {:ok, AddressCandidate.sort_by_score(body["candidates"])}
    else
      {:error, %Error{reason: reason}} -> {:error, reason}
      %Response{} -> {:error, :unsuccessful_response}
    end
  end
end

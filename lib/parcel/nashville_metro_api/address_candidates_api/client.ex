defmodule Parcel.NashvilleMetroApi.AddressCandidatesApi.Client do
  @doc """
  Fetches canonical address candidates for a given address.
  """
  @callback find_address_candidates(address :: String.t) :: {:ok, map()} | :error
end

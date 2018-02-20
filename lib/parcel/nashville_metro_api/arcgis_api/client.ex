defmodule Parcel.NashvilleMetroApi.ArcgisApi.Client do
  @doc """
  Fetches information about the ownership of parcels of land.  Contains information on features 
  of a parcel, such as a parcel ID.
  """
  @callback get_parcel_ownership_data(coordinates :: {float, float}) :: {:ok, map()} | :error
end

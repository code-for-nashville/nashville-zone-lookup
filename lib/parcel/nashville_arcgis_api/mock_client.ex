defmodule Parcel.NashvilleArcgisApi.MockClient do
  @behaviour Parcel.NashvilleArcgisApi.Client

  @impl true
  def geocode_address(_) do
    nil
  end

  @impl true
  def get_zone(_) do
    nil
  end
end

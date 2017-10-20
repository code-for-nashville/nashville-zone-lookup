defmodule Parcel.Zoning do
  @moduledoc """
  The Zoning context.
  """

  @address_candidates_api Application.get_env(:parcel, :address_candidates_api)

  @doc """
  Returns the list of address candidates sorted by score in descending order.
  """
  def list_address_candidates(address),
    do: @address_candidates_api.find_address_candidates(address)
end

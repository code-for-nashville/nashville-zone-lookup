defmodule Parcel.Zoning do
  @moduledoc """
  The Zoning context.
  """

  @address_candidates_api Application.get_env(:parcel, :address_candidates_api)
  @intended_uses Application.get_env(:parcel, :intended_uses)

  @doc """
  Returns the list of address candidates.
  """
  def list_address_candidates(address),
    do: @address_candidates_api.find_address_candidates(address)

  @doc """
  Returns the list of intended uses.
  """
  def list_intended_uses, do: {:ok, @intended_uses}
end

defmodule Parcel.Zoning.AddressCandidate do
  @doc """
  Sort the given address candidates by their score in descending order.  Address candidates without
  a score are ignored.
  """
  def sort_by_score(address_candidates) do
    address_candidates
    |> Enum.filter(&(&1["score"]))
    |> Enum.sort(&(&1["score"] >= &2["score"]))
  end
end

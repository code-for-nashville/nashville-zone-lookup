defmodule Parcel.ZoningTest do
  use ExUnit.Case, async: true

  import Mox

  alias Parcel.Zoning

  setup :verify_on_exit!

  describe "list_address_candidates/1" do
    test "returns what the address candidates client returns" do
      Parcel.NashvilleMetroApi.AddressCandidatesApi.MockClient
      |> expect(:find_address_candidates, fn _address -> {:ok, []} end)

      input = "500 Interstate Blvd S, Suite 300"

      assert Zoning.list_address_candidates(input) == {:ok, []}
    end
  end

  describe "list_intended_uses/0" do
    test "returns a static list of intended uses" do
      assert Zoning.list_intended_uses() == {:ok, Application.get_env(:parcel, :intended_uses)}
    end
  end
end

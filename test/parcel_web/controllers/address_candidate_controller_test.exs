defmodule ParcelWeb.AddressCandidateControllerTest do
  use ParcelWeb.ConnCase

  import Mox

  setup :verify_on_exit!

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2" do
    test "responds with address candidates if an address parameter is given and the external service is available", %{conn: conn} do
      Parcel.NashvilleMetroApi.AddressCandidatesApi.MockClient
      |> expect(:find_address_candidates, fn _address -> {:ok, []} end)

      params = [address: "500 Interstate Blvd S, Suite 300"]

      conn = get(conn, address_candidate_path(conn, :index), params)

      assert json_response(conn, 200) == %{"address_candidates" => []}
    end

    test "responds with an internal server error if an address parameter is given and the external service is not available", %{conn: conn} do
      Parcel.NashvilleMetroApi.AddressCandidatesApi.MockClient
      |> expect(:find_address_candidates, fn _address -> :error end)

      params = [address: "500 Interstate Blvd S, Suite 300"]

      conn = get(conn, address_candidate_path(conn, :index), params)

      assert json_response(conn, 500) == %{"message" => "Upstream address candidate service unavailable."}
    end

    test "responds with a bad request error if an address parameter is not given", %{conn: conn} do
      conn = get(conn, address_candidate_path(conn, :index))

      assert json_response(conn, 400) == %{"message" => "Missing address parameter."}
    end
  end
end

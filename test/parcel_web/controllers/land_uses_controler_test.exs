defmodule ParcelWeb.LandUsesControllerTest do
  use ParcelWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "Returns canned results", %{conn: conn} do
    params = [address: "500 Interstate Blvd S, Suite 300"]
    conn = get(conn, "/api/landuses", params)

    assert json_response(conn, 200) == ParcelWeb.LandUsesController.canned_result
  end
end

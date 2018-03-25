defmodule ParcelWeb.LandUsesControllerTest do
  use ParcelWeb.ConnCase

  import ParcelWeb.Router.Helpers

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "Returns canned results", %{conn: conn} do
    conn =
      get(conn, api_land_uses_path(conn, :index, address: "500 Interstate Blvd S, Suite 300"))

    assert json_response(conn, 200) == ParcelWeb.LandUsesController.canned_result()
  end
end

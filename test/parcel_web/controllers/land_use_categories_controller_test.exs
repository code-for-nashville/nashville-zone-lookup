defmodule ParcelWeb.LandUseCategoriesControllerTest do
  use ParcelWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "Returns canned results", %{conn: conn} do
    conn = get(conn, "/api/landusecategories")

    assert json_response(conn, 200) == ParcelWeb.LandUseCategoriesController.canned_result
  end
end

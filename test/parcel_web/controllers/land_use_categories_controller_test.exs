defmodule ParcelWeb.LandUseCategoriesControllerTest do
  use ParcelWeb.ConnCase

  import ParcelWeb.Router.Helpers
  alias Parcel.Zoning.LandUse

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "Returns canned results", %{conn: conn} do
    conn = get(conn, api_land_use_categories_path(conn, :index))

    assert json_response(conn, 200) == LandUse.categories()
  end
end

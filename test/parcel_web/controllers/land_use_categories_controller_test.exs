defmodule ParcelWeb.LandUseCategoriesControllerTest do
  use ExUnit.Case, async: true
  use ParcelWeb.ConnCase

  import ParcelWeb.Router.Helpers

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "Returns canned results", %{conn: conn} do
    conn = get(conn, api_land_use_categories_path(conn, :index))

    assert json_response(conn, 200) == %{
      "0" => "Residential",
      "1" => "Institutional",
      "2" => "Educational",
      "3" => "Office",
      "4" => "Medical",
      "5" => "Commercial",
      "6" => "Communication",
      "7" => "Industrial",
      "8" => "Transportation",
      "9" => "Utility",
      "10" => "Waste Management",
      "11" => "Recreation and Entertainment",
      "12" => "Other",
    }
  end
end

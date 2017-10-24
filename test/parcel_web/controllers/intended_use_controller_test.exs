defmodule ParcelWeb.IntendedUseControllerTest do
  use ParcelWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index/2" do
    test "responds with a list of all intended uses", %{conn: conn} do
      conn = get(conn, intended_use_path(conn, :index))

      expected = [
        %{"id" => 1, "name" => "Residential Uses"},
        %{"id" => 2, "name" => "Institutional Uses"},
        %{"id" => 3, "name" => "Educational Uses"},
        %{"id" => 4, "name" => "Office Uses"},
        %{"id" => 5, "name" => "Medical Uses"},
        %{"id" => 6, "name" => "Commercial Uses"},
        %{"id" => 7, "name" => "Communication Uses"},
        %{"id" => 8, "name" => "Industrial Uses"},
        %{"id" => 9, "name" => "Transportation Uses"},
        %{"id" => 10, "name" => "Utility Uses"},
        %{"id" => 11, "name" => "Waste Management Uses"},
        %{"id" => 12, "name" => "Recreation and Entertainment Uses"},
        %{"id" => 13, "name" => "Other Uses"}
      ]

      assert json_response(conn, 200)["intended_uses"] == expected
    end
  end
end

defmodule ParcelWeb.LandUsesControllerTest do
  alias Parcel.NashvilleArcgisApi.MockClient
  alias Parcel.Repo
  alias Parcel.Zoning.{LandUse, LandUseCondition, ZoningDistrict, ZoningDistrictLandUseCondition}

  import Mox
  import ParcelWeb.Router.Helpers

  use ParcelWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  setup :verify_on_exit!

  test "Returns canned results", %{conn: conn} do
    MockClient
    |> expect(:geocode_address, fn(_) -> {:ok, {0, 0}} end)
    |> expect(:get_zone, fn(_) -> {:ok, "IR"} end)

    # We need a
    # * ZoningDistrict
    # * two LandUses, one good, one bad
    # * our pre-existing LandUseCondition. Note that these are inserted
    # by ZoningDistrictLandUseCondition, so will error if they're the same.
    zone = Repo.insert! %ZoningDistrict{
        code: "IR",
        category: ZoningDistrict.category_industrial,
        description: "Industrial restrictive.  A wide range of light industrial uses at a small to moderate scale."
    }
    land_use_1 = %LandUse{category: LandUse.category_industrial, name: "Clothing manufacturing"}
    land_use_2 = %LandUse{category: LandUse.category_residential, name: "Residential"}

    Repo.insert! %ZoningDistrictLandUseCondition{
      land_use: land_use_1,
      zoning_district_id: zone.id,
      land_use_condition: LandUseCondition.p,
    }
    Repo.insert! %ZoningDistrictLandUseCondition{
      land_use: land_use_2,
      zoning_district_id: zone.id,
      land_use_condition: LandUseCondition.np,
    }

    conn =
      get(conn, api_land_uses_path(conn, :index, address: "500 Interstate Blvd S, Suite 300"))

    assert json_response(conn, 200) == %{
      "zone" => %{
        "code" => "IR",
        "description" => "Industrial restrictive.  A wide range of light industrial uses at a small to moderate scale.",
        "category" => "Industrial",
      },
      "land_uses" => [
        %{
          "category" => LandUse.category_industrial,
          "name" => "Clothing manufacturing",
          "condition" => %{
            "code" => LandUseCondition.p().code,
            "description" => LandUseCondition.p().description,
            "info_link" => LandUseCondition.p().info_link,
          }
        },
        %{
          "category" => LandUse.category_residential,
          "name" => "Residential",
          "condition" => %{
            "code" => LandUseCondition.np().code,
            "description" => LandUseCondition.np().description,
            "info_link" => LandUseCondition.np().info_link,
          }
        },
      ]
    }
  end
end

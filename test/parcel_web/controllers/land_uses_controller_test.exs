defmodule ParcelWeb.LandUsesControllerTest do
  alias Parcel.NashvilleArcgisApi.MockClient
  alias Parcel.Repo
  alias Parcel.Zoning.{LandUse, LandUseCondition, Zone, ZoneLandUseCondition}

  import Mox
  import ParcelWeb.Router.Helpers

  use ParcelWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  setup :verify_on_exit!

  test "Correctly queries the database and structures data", %{conn: conn} do
    MockClient
    |> expect(:geocode_address, fn(_) -> {:ok, {0, 0}} end)
    |> expect(:get_zone, fn(_) -> {:ok, "IR"} end)

    # We need a
    # * Zone
    # * two LandUses, one good, one bad
    # * our pre-existing LandUseCondition. Note that these are inserted
    # by ZoneLandUseCondition, so will error if they're the same.
    zone = Repo.insert! %Zone{
        code: "IR",
        category: Zone.category_industrial,
        description: "Industrial restrictive.  A wide range of light industrial uses at a small to moderate scale."
    }
    land_use_1 = %LandUse{category: LandUse.category_industrial, name: "Clothing manufacturing"}
    land_use_2 = %LandUse{category: LandUse.category_residential, name: "Residential"}

    Repo.insert! %ZoneLandUseCondition{
      land_use: land_use_1,
      zone_id: zone.id,
      land_use_condition: LandUseCondition.p,
    }
    Repo.insert! %ZoneLandUseCondition{
      land_use: land_use_2,
      zone_id: zone.id,
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
            "category" => LandUseCondition.p().category,
            "description" => LandUseCondition.p().description,
            "info_link" => LandUseCondition.p().info_link,
          }
        },
        %{
          "category" => LandUse.category_residential,
          "name" => "Residential",
          "condition" => %{
            "code" => LandUseCondition.np().code,
            "category" => LandUseCondition.np().category,
            "description" => LandUseCondition.np().description,
            "info_link" => LandUseCondition.np().info_link,
          }
        },
      ]
    }
  end
end

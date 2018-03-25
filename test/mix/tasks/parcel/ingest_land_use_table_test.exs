defmodule Mix.Tasks.Parcel.IngestLandUseTableTest do
  @moduledoc """
  Run through and test output for a very shortened file
  """
  use ExUnit.Case, async: true

  alias Mix.Tasks.Parcel.IngestLandUseTable
  alias Parcel.Repo
  alias Parcel.Zoning.{LandUse, LandUseCondition, ZoningDistrict}

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Parcel.Repo)
  end

  # This fixture contains a sample of data from a real land use table
  # input downloaded from nashville.gov
  @land_use_table_csv Path.join(
                        Path.dirname(__ENV__.file),
                        "fixtures/land_use_table_sample.xls.csv"
                      )

  doctest IngestLandUseTable

  describe "run/1" do
    test "end to end test that a flattened list of zoning conditions are returned for a sample file" do
      seed_data()
      actual = IngestLandUseTable.run([@land_use_table_csv])

      expected = [
        %{land_use: "Single-family", zoning_district: "AG", land_use_condition: "P"},
        %{land_use: "Single-family", zoning_district: "AR2a", land_use_condition: "P"},
        %{land_use: "Single-family", zoning_district: "RM40", land_use_condition: "P"},
        %{land_use: "Single-family", zoning_district: "RM40-A", land_use_condition: "P"},
        %{land_use: "Single-family", zoning_district: "RM60", land_use_condition: "P"},
        %{land_use: "Single-family", zoning_district: "RM60-A", land_use_condition: "P"},
        %{land_use: "Single-family", zoning_district: "RM80-A", land_use_condition: "P"},
        %{land_use: "Single-family", zoning_district: "RM100-A", land_use_condition: "P"},
        %{land_use: "Single-family", zoning_district: "MHP", land_use_condition: "NP"},
        %{land_use: "Single-family", zoning_district: "SP", land_use_condition: "A"},
        %{land_use: "Single-family", zoning_district: "MUN", land_use_condition: "P"},
        %{land_use: "Single-family", zoning_district: "MUN-A", land_use_condition: "P"},
        %{land_use: "Two-family", zoning_district: "AG", land_use_condition: "PC"},
        %{land_use: "Two-family", zoning_district: "AR2a", land_use_condition: "PC"},
        %{land_use: "Two-family", zoning_district: "RM40", land_use_condition: "P"},
        %{land_use: "Two-family", zoning_district: "RM40-A", land_use_condition: "P"},
        %{land_use: "Two-family", zoning_district: "RM60", land_use_condition: "P"},
        %{land_use: "Two-family", zoning_district: "RM60-A", land_use_condition: "P"},
        %{land_use: "Two-family", zoning_district: "RM80-A", land_use_condition: "P"},
        %{land_use: "Two-family", zoning_district: "RM100-A", land_use_condition: "P"},
        %{land_use: "Two-family", zoning_district: "MHP", land_use_condition: "NP"},
        %{land_use: "Two-family", zoning_district: "SP", land_use_condition: "NP"},
        %{land_use: "Two-family", zoning_district: "MUN", land_use_condition: "P"},
        %{land_use: "Two-family", zoning_district: "MUN-A", land_use_condition: "P"}
      ]

      actual = Repo.preload(actual, [:zoning_district, :land_use_condition, :land_use])

      simple_actual =
        Enum.map(
          actual,
          &%{
            land_use: &1.land_use.name,
            zoning_district: &1.zoning_district.code,
            land_use_condition: &1.land_use_condition.code
          }
        )

      assert expected == simple_actual
    end
  end

  def seed_data do
    # Copied anything from seeds.exs needed to run sample.xls.csv
    # Land Use Conditions
    Repo.insert!(LandUseCondition.p())
    Repo.insert!(LandUseCondition.np())
    Repo.insert!(LandUseCondition.pc())
    Repo.insert!(LandUseCondition.a())

    # Zoning Districts
    Repo.insert!(%ZoningDistrict{
      code: "AG",
      category: ZoningDistrict.category_agricultural(),
      description:
        "Very low density residential development generally on unsubdivided tracts of land where public sanitary sewer service and public water supply are least practical."
    })

    Repo.insert!(%ZoningDistrict{
      code: "AR2a",
      category: ZoningDistrict.category_agricultural(),
      description:
        "Very low density residential development generally on unsubdivided tracts of land where public sanitary sewer service and public water supply are least practical."
    })

    Repo.insert!(%ZoningDistrict{
      code: "RM40",
      category: ZoningDistrict.category_residential(),
      description:
        "High intensity multifamily development, typically characterized by mid- and high-rise structures and structured parking.  40 units an acre."
    })

    Repo.insert!(%ZoningDistrict{
      code: "RM40-A",
      category: ZoningDistrict.category_residential(),
      description:
        "High intensity multifamily development, typically characterized by mid- and high-rise structures and structured parking.  40 units an acre."
    })

    Repo.insert!(%ZoningDistrict{
      code: "RM60",
      category: ZoningDistrict.category_residential(),
      description:
        "High intensity multifamily development, typically characterized by mid- and high-rise structures and structured parking.  60 units an acre."
    })

    Repo.insert!(%ZoningDistrict{
      code: "RM60-A",
      category: ZoningDistrict.category_residential(),
      description:
        "High intensity multifamily development, typically characterized by mid- and high-rise structures and structured parking.  60 units an acre."
    })

    Repo.insert!(%ZoningDistrict{
      code: "RM80-A",
      category: ZoningDistrict.category_residential(),
      description:
        "High intensity residential structures, typically characterized by mid- and high-rise structures and structured parking.  80 units an acre."
    })

    Repo.insert!(%ZoningDistrict{
      code: "RM100-A",
      category: ZoningDistrict.category_residential(),
      description:
        "High intensity residential structures, typically characterized by mid- and high-rise structures and structured parking.  100 units an acre."
    })

    Repo.insert!(%ZoningDistrict{
      code: "MHP",
      category: ZoningDistrict.category_residential(),
      description: "Mobile home parks."
    })

    Repo.insert!(%ZoningDistrict{
      code: "SP",
      category: ZoningDistrict.category_specific_plan(),
      description: "Specific plan.  Context sensitive development and land use compatibility."
    })

    Repo.insert!(%ZoningDistrict{
      code: "MUN",
      category: ZoningDistrict.category_mixed_use(),
      description:
        "Mixed-use neighborhood.  Lower intensity mixture of residential, office, personal service and retail shopping."
    })

    Repo.insert!(%ZoningDistrict{
      code: "MUN-A",
      category: ZoningDistrict.category_mixed_use(),
      description:
        "Mixed-use neighborhood alternative.  Lower intensity mixture mixture of residential, office, personal service and retail shopping."
    })
  end
end

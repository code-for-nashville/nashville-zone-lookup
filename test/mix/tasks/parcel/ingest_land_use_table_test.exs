defmodule Mix.Tasks.Parcel.IngestLandUseTableTest do
  @moduledoc """
  Run through and test output for a very shortened file
  """
  use ExUnit.Case, async: true

  alias Mix.Tasks.Parcel.IngestLandUseTable
  alias Parcel.Repo
  alias Parcel.Zoning.{LandUse, LandUseCondition, Zone}

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
        %{land_use: "Single-family", zone: "AG", land_use_condition: "P"},
        %{land_use: "Single-family", zone: "AR2a", land_use_condition: "P"},
        %{land_use: "Single-family", zone: "RM40", land_use_condition: "P"},
        %{land_use: "Single-family", zone: "RM40-A", land_use_condition: "P"},
        %{land_use: "Single-family", zone: "RM60", land_use_condition: "P"},
        %{land_use: "Single-family", zone: "RM60-A", land_use_condition: "P"},
        %{land_use: "Single-family", zone: "RM80-A", land_use_condition: "P"},
        %{land_use: "Single-family", zone: "RM100-A", land_use_condition: "P"},
        %{land_use: "Single-family", zone: "MHP", land_use_condition: "NP"},
        %{land_use: "Single-family", zone: "SP", land_use_condition: "A"},
        %{land_use: "Single-family", zone: "MUN", land_use_condition: "P"},
        %{land_use: "Single-family", zone: "MUN-A", land_use_condition: "P"},
        %{land_use: "Two-family", zone: "AG", land_use_condition: "PC"},
        %{land_use: "Two-family", zone: "AR2a", land_use_condition: "PC"},
        %{land_use: "Two-family", zone: "RM40", land_use_condition: "P"},
        %{land_use: "Two-family", zone: "RM40-A", land_use_condition: "P"},
        %{land_use: "Two-family", zone: "RM60", land_use_condition: "P"},
        %{land_use: "Two-family", zone: "RM60-A", land_use_condition: "P"},
        %{land_use: "Two-family", zone: "RM80-A", land_use_condition: "P"},
        %{land_use: "Two-family", zone: "RM100-A", land_use_condition: "P"},
        %{land_use: "Two-family", zone: "MHP", land_use_condition: "NP"},
        %{land_use: "Two-family", zone: "SP", land_use_condition: "NP"},
        %{land_use: "Two-family", zone: "MUN", land_use_condition: "P"},
        %{land_use: "Two-family", zone: "MUN-A", land_use_condition: "P"}
      ]

      actual = Repo.preload(actual, [:zone, :land_use_condition, :land_use])

      simple_actual =
        Enum.map(
          actual,
          &%{
            land_use: &1.land_use.name,
            zone: &1.zone.code,
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

    # Zones
    Repo.insert!(%Zone{
      code: "AG",
      category: Zone.category_agricultural(),
      description:
        "Very low density residential development generally on unsubdivided tracts of land where public sanitary sewer service and public water supply are least practical."
    })

    Repo.insert!(%Zone{
      code: "AR2a",
      category: Zone.category_agricultural(),
      description:
        "Very low density residential development generally on unsubdivided tracts of land where public sanitary sewer service and public water supply are least practical."
    })

    Repo.insert!(%Zone{
      code: "RM40",
      category: Zone.category_residential(),
      description:
        "High intensity multifamily development, typically characterized by mid- and high-rise structures and structured parking.  40 units an acre."
    })

    Repo.insert!(%Zone{
      code: "RM40-A",
      category: Zone.category_residential(),
      description:
        "High intensity multifamily development, typically characterized by mid- and high-rise structures and structured parking.  40 units an acre."
    })

    Repo.insert!(%Zone{
      code: "RM60",
      category: Zone.category_residential(),
      description:
        "High intensity multifamily development, typically characterized by mid- and high-rise structures and structured parking.  60 units an acre."
    })

    Repo.insert!(%Zone{
      code: "RM60-A",
      category: Zone.category_residential(),
      description:
        "High intensity multifamily development, typically characterized by mid- and high-rise structures and structured parking.  60 units an acre."
    })

    Repo.insert!(%Zone{
      code: "RM80-A",
      category: Zone.category_residential(),
      description:
        "High intensity residential structures, typically characterized by mid- and high-rise structures and structured parking.  80 units an acre."
    })

    Repo.insert!(%Zone{
      code: "RM100-A",
      category: Zone.category_residential(),
      description:
        "High intensity residential structures, typically characterized by mid- and high-rise structures and structured parking.  100 units an acre."
    })

    Repo.insert!(%Zone{
      code: "MHP",
      category: Zone.category_residential(),
      description: "Mobile home parks."
    })

    Repo.insert!(%Zone{
      code: "SP",
      category: Zone.category_specific_plan(),
      description: "Specific plan.  Context sensitive development and land use compatibility."
    })

    Repo.insert!(%Zone{
      code: "MUN",
      category: Zone.category_mixed_use(),
      description:
        "Mixed-use neighborhood.  Lower intensity mixture of residential, office, personal service and retail shopping."
    })

    Repo.insert!(%Zone{
      code: "MUN-A",
      category: Zone.category_mixed_use(),
      description:
        "Mixed-use neighborhood alternative.  Lower intensity mixture mixture of residential, office, personal service and retail shopping."
    })
  end
end

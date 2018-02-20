defmodule Mix.Tasks.Parcel.IngestLandUseTableTest do
  @moduledoc """
  Run through and test output for a very shortened file
  """
  use ExUnit.Case, async: true

  alias Mix.Tasks.Parcel.IngestLandUseTable
  alias Parcel.Domain.ZoningDistrictLandUseCondition

  # This fixture contains a sample of data from a real land use table
  # input downloaded from nashville.gov
  @land_use_table_csv Path.join(
    Path.dirname(__ENV__.file),
    "fixtures/land_use_table_sample.xls.csv"
  )

  doctest IngestLandUseTable

  describe "run/1" do
    test "end to end test that a flattened list of zoning conditions are returned for a sample file" do
      actual = IngestLandUseTable.run([@land_use_table_csv])
      expected = [
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "AG", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "AR2a", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "RM40", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "RM40-A", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "RM60", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "RM60-A", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "RM80-A", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "RM100-A", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "MHP", land_use_condition: "NP"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "SP", land_use_condition: "A"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "MUN", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Single-family", zoning_district: "MUN-A", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "AG", land_use_condition: "PC"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "AR2a", land_use_condition: "PC"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "RM40", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "RM40-A", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "RM60", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "RM60-A", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "RM80-A", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "RM100-A", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "MHP", land_use_condition: "NP"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "SP", land_use_condition: "NP"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "MUN", land_use_condition: "P"},
        %ZoningDistrictLandUseCondition{land_use: "Two-family", zoning_district: "MUN-A", land_use_condition: "P"}
      ]
      assert expected == actual
    end
  end
end

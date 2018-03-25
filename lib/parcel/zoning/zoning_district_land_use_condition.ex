defmodule Parcel.Zoning.ZoningDistrictLandUseCondition do
  @moduledoc ~S"""
  The `Parcel.Domain.LandUseCondition` under which a `Parcel.Domain.LandUse`
  can be performed in a `Parcel.Domain.ZoningDistrict`.

  Only one `Parcel.Domain.LandUseCondition` should be defined for each
  `Parcel.Domain.LandUse`/`Parcel.Domain.ZoningDistrict` pair.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Parcel.Zoning.{LandUse, LandUseCondition, ZoningDistrict, ZoningDistrictLandUseCondition}

  schema "zoning_district_land_use_conditions" do
    belongs_to(:land_use, LandUse)
    belongs_to(:land_use_condition, LandUseCondition)
    belongs_to(:zoning_district, ZoningDistrict)

    timestamps()
  end

  @doc false
  def changeset(%ZoningDistrictLandUseCondition{} = zoning_district_land_use_condition, attrs) do
    zoning_district_land_use_condition
    |> cast(attrs, [:land_use_id, :land_use_condition_id, :zoning_district_id])
    |> validate_required([:land_use_id, :land_use_condition_id, :zoning_district_id])
    |> unique_constraint(
      :zoning_district,
      name: :zoning_district_land_use_conditions_zoning_district_id_land_use
    )
  end
end

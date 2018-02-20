defmodule Parcel.Domain.ZoningDistrictLandUseCondition do
  @moduledoc ~S"""
  The `Parcel.Domain.LandUseCondition` under which a `Parcel.Domain.LandUse`
  can be performed in a `Parcel.Domain.ZoningDistrict`.

  Only one `Parcel.Domain.LandUseCondition` should be defined for each
  `Parcel.Domain.LandUse`/`Parcel.Domain.ZoningDistrict` pair.

  ## Example

      iex> %Parcel.Domain.ZoningDistrictLandUseCondition{
      ...>   land_use: %Parcel.Domain.LandUse{category: "Recreation", name: "Raquetball"},
      ...>   land_use_condition: %Parcel.Domain.LandUseCondition{category: :permitted, code: "P", description: "Permitted by right."},
      ...>   zoning_district: %Parcel.Domain.ZoningDistrict{category: "Industrial", code: "IWD"}
      ...> }
      %Parcel.Domain.ZoningDistrictLandUseCondition{
        land_use: %Parcel.Domain.LandUse{category: "Recreation", name: "Raquetball"},
        land_use_condition: %Parcel.Domain.LandUseCondition{category: :permitted, code: "P", description: "Permitted by right."},
        zoning_district: %Parcel.Domain.ZoningDistrict{category: "Industrial", code: "IWD"}
      }
  """
  @enforce_keys [:land_use, :land_use_condition, :zoning_district]

  defstruct [
    :land_use,
    :land_use_condition,
    :zoning_district
  ]
end

defmodule Parcel.Domain.ZoningDistrict do
  @moduledoc ~S"""
  A `Parcel.Domain.ZoningDistrict` defines and limits acceptable land use for
  property within the district.

  Each Zoning District is assigned an alphanumeric
  `:code` that is unique within its `:region`. A Zoning District is often
  referred to as simply a "zone".

  For the purposes of this project, the `:region` will always
  be set to the `Parcel.Domain.Constants.nashville_region` constant.  Even
  though it is always one value in this project, the `:region` attribute
  allows us to accomodate additional districts in the future.

  While Zoning Districts are somewhat arbitrary, they usually fit into
  a pre-defined `:category`.

  A Zoning District may include a short textual `:description`.  This usually
  describes the type of property included in this zone and should be a
  complete sentence, as it will likely appear in the user interface.

  ## Example

      iex> %Parcel.Domain.ZoningDistrict{
      ...>   category: "Residential",
      ...>   code: "R80",
      ...>   description: "Single family unit, with a lot greater than or equal to 80,000ft."
      ...> }
      %Parcel.Domain.ZoningDistrict{
        category: "Residential",
        code: "R80",
        description: "Single family unit, with a lot greater than or equal to 80,000ft.",
        region: Parcel.Domain.Constants.nashville_region
      }
  """
  alias Parcel.Domain.Constants

  @enforce_keys [:category, :code]

  defstruct [
    :category,
    :code,
    description: "",
    region: Constants.nashville_region
  ]
end

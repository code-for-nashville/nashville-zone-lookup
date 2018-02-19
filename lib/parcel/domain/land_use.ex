defmodule Parcel.Domain.LandUse do
  @moduledoc ~S"""
  An arrangement, activity, or input that might be undertaken on a property

  For example, a Land Use might be a class of business ("Bed and breakfast
  inn"), an agricultural activity ("Domestic hens"), or an institution
  ("Correctional facility").

  A Land Use has a `:name` that is unique within a `:region`. Land Uses also
  have a `:category`, such as "Residential" or "Industrial" that can be used
  to group similar Land Uses.

  ## Example

      iex> %Parcel.Domain.LandUse{
      ...>   category: "Utility",
      ...>   name: "Water/sewer pump station"
      ...> }
      %Parcel.Domain.LandUse{
        category: "Utility",
        name: "Water/sewer pump station",
        region: Parcel.Domain.Constants.nashville_region
      }
  """
  alias Parcel.Domain.Constants

  @enforce_keys [:category, :name]

  defstruct [
    :category,
    :name,
    region: Constants.nashville_region
  ]
end

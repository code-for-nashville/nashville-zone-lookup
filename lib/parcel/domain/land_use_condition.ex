defmodule Parcel.Domain.LandUseCondition do
  @moduledoc ~S"""
  The conditions under which a `Parcel.Domain.LandUse` can be performed.

  Many `Parcel.Domain.LandUse` are unconditionally permitted ("Permitted by
  right" in Nashville's terminology) for a particular
  `Parcel.Domain.ZoningDistrict`.  However, other `Parcel.Domain.LandUse`
  are only permitted under specific conditions. For example, the Land Use
  may require approval from a zoning board, or can only be permitted withing
  an overlay district.

  A Land Use Condition is identified by an alphanumeric `:code` that is
  unique within a `:region`.  It also includes a textual `:description`
  briefly describing the condition in a complet sentence.  Perhaps
  most importantly, a Land Use Condition must fall into a `:condition_category`,
  one of `[:permitted, :conditionally_permitted, :not_permitted]`.  This makes
  it simple to translate various Land Use Conditions into visual cues and
  workflows for the user.

  A Land Use Condition can optionally include an `:info_link`, a valid
  URI pointing to a more complete description of the condition.

  ## Example

      iex> %Parcel.Domain.LandUseCondition{
      ...>   category: :conditionally_permitted,
      ...>   code: "PC",
      ...>   description: "Permitted subject to certain conditions.",
      ...>   info_link: "https://library.municode.com/tn/metro_government_of_nashville_and_davidson_county/codes/code_of_ordinances?nodeId=CD_TIT17ZO_CH17.16LAUSDEST_ARTIIUSPECOPC",
      ...> }
      %Parcel.Domain.LandUseCondition{
        category: :conditionally_permitted,
        code: "PC",
        description: "Permitted subject to certain conditions.",
        info_link: "https://library.municode.com/tn/metro_government_of_nashville_and_davidson_county/codes/code_of_ordinances?nodeId=CD_TIT17ZO_CH17.16LAUSDEST_ARTIIUSPECOPC",
        region: Parcel.Domain.Constants.nashville_region
      }
  """
  alias Parcel.Domain.Constants

  @enforce_keys [:category, :code, :description]

  defstruct [
    :category,
    :code,
    :description,
    # `:info_link` is either nil or a valid URL
    :info_link,
    region: Constants.nashville_region
  ]
end

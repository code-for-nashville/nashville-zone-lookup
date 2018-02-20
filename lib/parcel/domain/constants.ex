defmodule Parcel.Domain.Constants do
  @moduledoc """
  Constants for `Parcel.Domain` modules.
  """

  @doc """
  Constant string for the Nashville `:region`.

  This gets used as the default `:region` in `Parcel.Domain.ZoningDistrict`,
  `Parcel.Domain.LandUseCondition`, and  `Parcel.Domain.LandUse`.
  """
  def nashville_region() do
    "Metropolitan Nashville and Davidson County"
  end
end

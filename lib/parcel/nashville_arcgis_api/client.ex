defmodule Parcel.NashvilleArcgisApi.Client do
  @typedoc """
  A point with x, y coordinates.

  All points for this API are expected to use the Web Mercator spatial
  reference. See
  https://developers.arcgis.com/documentation/common-data-types/geometry-objects.htm#POINT
  for more information.
  """
  @type point :: {float, float}

  @typedoc """
  An error consists of an Atom label, and a String message
  """
  @type error :: {Atom, String}

  @doc """
  Retrieve a geocode for a given Nashville address.
  """
  @callback geocode_address(address :: String) :: {:ok, point} | error

  @doc """
  Retrieve the short Zoning code for a geographic point in Nashville.

  For example, "MUI", "AG".
  """
  @callback get_zone(point :: point) :: {:ok, String} | error
end

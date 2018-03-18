defmodule Parcel.Domain.ZoningDistrictTest do
  use ExUnit.Case, async: true

  doctest Parcel.Domain.ZoningDistrict
end

defmodule Parcel.Domain.LandUseTest do
  use ExUnit.Case, async: true

  doctest Parcel.Domain.LandUse
end

defmodule Parcel.Domain.LandUseConditionTest do
  use ExUnit.Case, async: true

  doctest Parcel.Domain.LandUseCondition
end

defmodule Parcel.Domain.ZoningDistrictLandUseConditionTest do
  use ExUnit.Case, async: true

  doctest Parcel.Domain.ZoningDistrictLandUseCondition
end

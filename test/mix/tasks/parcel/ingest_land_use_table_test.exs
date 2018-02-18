defmodule Mix.Tasks.Parcel.IngestLandUseTest do
  use ExUnit.Case, async: true

  import Mox

  doctest Mix.Tasks.Parcel.IngestLandUseTable

  setup :verify_on_exit!
end

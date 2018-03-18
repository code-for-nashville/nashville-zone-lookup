defmodule Parcel.NashvilleArcgisApiTest do
  use ExUnit.Case, async: true

  alias Parcel.NashvilleArcgisApi.HttpClient

  @tag :external
  describe "geocode_address/1" do
    test "Returns the geocode of a valid address" do
      address_snippet = "2606 8th Ave South"
      # Obtained by manually calling the Metro ArcGIS with the input address
      expected_point = {-9659692.8081893716, 4317462.809491253}
      assert HttpClient.geocode_address(address_snippet) == {:ok, expected_point}
    end
  end

  @tag :external
  describe "get_zone/1" do
    test "Returns the correct zone for a point" do
      # Geocoded point for 1015 West Kirkland Ave.
      point = {-9655510.7980420645, 4329598.7734783599}
      expected_zone_code = "IR"
      assert HttpClient.get_zone(point) == {:ok, expected_zone_code}
    end
  end
end

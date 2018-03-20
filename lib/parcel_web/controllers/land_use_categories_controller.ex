defmodule ParcelWeb.LandUseCategoriesController do
  use ParcelWeb, :controller

  action_fallback ParcelWeb.FallbackController

  def canned_result do
    [
      %{"id" => 1, "name" => "Residential Uses"},
      %{"id" => 2, "name" => "Institutional Uses"},
      %{"id" => 3, "name" => "Educational Uses"},
      %{"id" => 4, "name" => "Office Uses"},
      %{"id" => 5, "name" => "Medical Uses"},
      %{"id" => 6, "name" => "Commercial Uses"},
      %{"id" => 7, "name" => "Communication Uses"},
      %{"id" => 8, "name" => "Industrial Uses"},
      %{"id" => 9, "name" => "Transportation Uses"},
      %{"id" => 10, "name" => "Utility Uses"},
      %{"id" => 11, "name" => "Waste Management Uses"},
      %{"id" => 12, "name" => "Recreation and Entertainment Uses"},
      %{"id" => 13, "name" => "Other Uses"}
    ]
  end

  def index(conn, _params) do
    json conn, canned_result()
  end
end

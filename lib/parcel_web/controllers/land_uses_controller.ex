defmodule ParcelWeb.LandUsesController do
  use ParcelWeb, :controller

  def canned_result do
    %{
      "zone" => %{
        "code" => "RS40",
        "description" => "Small houses for families",
        "category" => "Residential",
      },
      "land_uses" => [
        %{
          "category" => "Residential",
          "description" => "Build a house for your family less than 40K sqft",
          "condition_code" => "P"  # Permitted by right
        },
        %{
          "category" => "Residential",
          "description" => "Build a house for your family larger than 40K sqft",
          "condition_code" => "NP"  # Not permitted
        },
        %{
          "category" => "Industrial",
          "description" => "Build a warehouse",
          "condition_code" => "NP"
        }
      ]
    }
  end

  def index(conn, %{"address" => address}) do
    render(conn, "index.json", land_uses_report: canned_result)
  end

  def index(_conn, _params), do: { :error,  :bad_request, "Missing address parameter."}
end

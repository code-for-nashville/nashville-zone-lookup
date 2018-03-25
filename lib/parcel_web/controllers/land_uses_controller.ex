defmodule ParcelWeb.LandUsesController do
  use ParcelWeb, :controller

  action_fallback(ParcelWeb.FallbackController)

  def canned_result do
    %{
      "zone" => %{
        "code" => "RS40",
        "description" => "Small houses for families",
        "category" => "Residential"
      },
      "land_uses" => [
        %{
          "category" => "Residential",
          "description" => "Build a house for your family less than 40K sqft",
          # Permitted by right
          "condition_code" => "P"
        },
        %{
          "category" => "Residential",
          "description" => "Build a house for your family larger than 40K sqft",
          # Not permitted
          "condition_code" => "NP"
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
    json(conn, canned_result())
  end

  def index(_conn, _params), do: {:error, :bad_request, "Missing address parameter."}
end

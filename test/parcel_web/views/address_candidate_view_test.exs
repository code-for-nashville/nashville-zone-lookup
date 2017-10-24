defmodule ParcelWeb.AddressCandidateViewTest do
  use ParcelWeb.ConnCase, async: true

  import Phoenix.View

  test "renders index.json" do
    address_candidates = %{
      address_candidates: [
        %{
          "address" => "500 INTERSTATE BLVD S, 37210",
          "score" => 100.0
        }
      ]
    }
    response_string = "{\"address_candidates\":[{\"score\":100.0,\"address\":\"500 INTERSTATE BLVD S, 37210\"}]}"

    assert render_to_string(ParcelWeb.AddressCandidateView, "index.json", address_candidates) == response_string
  end

  test "render address_candidate.json" do
    address_candidate = %{
      address_candidate: %{
        "address" => "500 INTERSTATE BLVD S, 37210",
        "score" => 100.0
      }
    }
    response_string = "{\"score\":100.0,\"address\":\"500 INTERSTATE BLVD S, 37210\"}"

    assert render_to_string(ParcelWeb.AddressCandidateView, "address_candidate.json", address_candidate) == response_string
  end
end

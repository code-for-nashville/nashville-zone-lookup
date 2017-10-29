defmodule ParcelWeb.IntendedUseViewTest do
  use ParcelWeb.ConnCase, async: true

  import Phoenix.View

  test "renders index.json" do
    intended_uses = %{
      intended_uses: [
        %{
          id: 1,
          name: "Residential Uses"
        }
      ]
    }
    response_string = "{\"intended_uses\":[{\"name\":\"Residential Uses\",\"id\":1}]}"

    assert render_to_string(ParcelWeb.IntendedUseView, "index.json", intended_uses) == response_string
  end

  test "render intended_use.json" do
    intended_use = %{
      intended_use: %{
        id: 1,
        name: "Residential Uses"
      }
    }
    response_string = "{\"name\":\"Residential Uses\",\"id\":1}"

    assert render_to_string(ParcelWeb.IntendedUseView, "intended_use.json", intended_use) == response_string
  end
end

defmodule ParcelWeb.LandUsesView do
  use ParcelWeb, :view

  def render("index.json", %{land_uses_report: land_uses_report}) do
    land_uses_report
  end
end

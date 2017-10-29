defmodule ParcelWeb.IntendedUseView do
  use ParcelWeb, :view
  alias ParcelWeb.IntendedUseView

  def render("index.json", %{intended_uses: intended_uses}) do
    %{intended_uses: render_many(intended_uses, IntendedUseView, "intended_use.json")}
  end

  def render("intended_use.json", %{intended_use: intended_use}) do
    %{
      id: intended_use.id,
      name: intended_use.name
    }
  end
end

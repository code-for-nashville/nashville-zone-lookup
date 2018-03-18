defmodule ParcelWeb.LandUseCategoriesView do
  use ParcelWeb, :view

  def render("index.json", %{land_use_categories: categories}) do
    categories
  end
end

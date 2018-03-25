defmodule ParcelWeb.LandUseCategoriesController do
  use ParcelWeb, :controller
  alias Parcel.Zoning.LandUse
  action_fallback(ParcelWeb.FallbackController)

  def index(conn, _params) do
    json(conn, LandUse.categories())
  end
end

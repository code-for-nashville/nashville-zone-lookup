defmodule ParcelWeb.LandUseCategoriesController do
  use ParcelWeb, :controller
  alias Parcel.Zoning.LandUse

  action_fallback(ParcelWeb.FallbackController)

  def index(conn, _params) do
    index_to_items =
      Enum.with_index(LandUse.categories())
      |> Enum.reduce(%{}, fn {item, index}, acc ->
        Map.put(acc, "#{index}", item)
      end)

    json(conn, index_to_items)
  end
end

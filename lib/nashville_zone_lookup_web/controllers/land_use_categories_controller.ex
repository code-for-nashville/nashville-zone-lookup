defmodule NashvilleZoneLookupWeb.LandUseCategoriesController do
  use NashvilleZoneLookupWeb, :controller
  alias NashvilleZoneLookup.Zoning.LandUse

  action_fallback(NashvilleZoneLookupWeb.FallbackController)

  def index(conn, _params) do
    index_to_items =
      Enum.with_index(LandUse.categories())
      |> Enum.reduce(%{}, fn {item, index}, acc ->
        Map.put(acc, "#{index}", item)
      end)

    json(conn, index_to_items)
  end
end

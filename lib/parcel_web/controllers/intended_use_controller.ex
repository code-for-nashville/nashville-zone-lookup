defmodule ParcelWeb.IntendedUseController do
  use ParcelWeb, :controller

  alias Parcel.Zoning

  action_fallback ParcelWeb.FallbackController

  def index(conn, _params) do
    case Zoning.list_intended_uses() do
      {:ok, intended_uses} -> render(conn, "index.json", intended_uses: intended_uses)
    end
  end
end

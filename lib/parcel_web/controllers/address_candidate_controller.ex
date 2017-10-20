defmodule ParcelWeb.AddressCandidateController do
  use ParcelWeb, :controller

  require Logger

  alias Parcel.Zoning

  action_fallback ParcelWeb.FallbackController

  def index(conn, %{"address" => address}) do
    case Zoning.list_address_candidates(address) do
      {:ok, address_candidates} -> render(conn, "index.json", address_candidates: address_candidates)
      :error -> {:error, :internal_server_error}
    end
  end

  def index(_conn, _params), do: {:error, :bad_request}
end

defmodule ParcelWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ParcelWeb, :controller

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> render(ParcelWeb.ErrorView, :"400")
  end

  def call(conn, {:error, :internal_server_error}) do
    conn
    |> put_status(:internal_server_error)
    |> render(ParcelWeb.ErrorView, :"500")
  end
end

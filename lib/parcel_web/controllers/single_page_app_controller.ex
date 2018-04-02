defmodule ParcelWeb.SinglePageAppController do
  @moduledoc """
  Controller for the Parcel single page application in frontend/

  This serves up the built `index.html` directly from the frontend directory.
  """
  use ParcelWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_header("content-type", "text/html; charset=utf-8")
    |> Plug.Conn.send_file(200, "frontend/dist/index.html")
  end
end

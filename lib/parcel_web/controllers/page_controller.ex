defmodule ParcelWeb.PageController do
  use ParcelWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule ParcelWeb.Router do
  use ParcelWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope "/api", ParcelWeb, as: :api do
    pipe_through(:api)

    # /landuses has a required "address" query param
    get("/landuses", LandUsesController, :index)

    get("/landusecategories", LandUseCategoriesController, :index)
  end

  scope "/", ParcelWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", SinglePageAppController, :index)
  end
end

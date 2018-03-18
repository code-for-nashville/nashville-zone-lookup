defmodule ParcelWeb.Router do
  use ParcelWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/api", ParcelWeb do
    pipe_through :api

    # /landuses has a required "address" query param
    get "/landuses", LandUsesController, :index

    get "/landusecategories", LandUseCategoriesController, :index
  end

  scope "/", ParcelWeb do
    pipe_through :browser # Use the default browser stack

    get "/*page", PageController, :index
  end
end

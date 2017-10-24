# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :parcel, ParcelWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zLG/tBftJI2Jf2PBgQNAjta6anAIO4keIwZf75AhdBFUl1Zfvsd9seHwg6iaGwxY",
  render_errors: [view: ParcelWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Parcel.PubSub,
           adapter: Phoenix.PubSub.PG2]

# configures address candidate API to use
config :parcel, :address_candidates_api, Parcel.NashvilleMetroApi.AddressCandidatesApi.HttpClient

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :parcel, Parcel.NashvilleMetroApi.AddressCandidatesApi.HttpClient,
  max_locations: 5

config :parcel, :intended_uses,
  [
    %{id: 1, name: "Residential Uses"},
    %{id: 2, name: "Institutional Uses"},
    %{id: 3, name: "Educational Uses"},
    %{id: 4, name: "Office Uses"},
    %{id: 5, name: "Medical Uses"},
    %{id: 6, name: "Commercial Uses"},
    %{id: 7, name: "Communication Uses"},
    %{id: 8, name: "Industrial Uses"},
    %{id: 9, name: "Transportation Uses"},
    %{id: 10, name: "Utility Uses"},
    %{id: 11, name: "Waste Management Uses"},
    %{id: 12, name: "Recreation and Entertainment Uses"},
    %{id: 13, name: "Other Uses"}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

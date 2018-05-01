# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# general application configuration
config :nashville_zone_lookup, ecto_repos: [NashvilleZoneLookup.Repo]

# Configures the endpoint
config :nashville_zone_lookup, NashvilleZoneLookupWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zLG/tBftJI2Jf2PBgQNAjta6anAIO4keIwZf75AhdBFUl1Zfvsd9seHwg6iaGwxY",
  render_errors: [view: NashvilleZoneLookupWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NashvilleZoneLookup.PubSub, adapter: Phoenix.PubSub.PG2]

# configures address candidate API to use
config :nashville_zone_lookup, :nashville_arc_gis_api, NashvilleZoneLookup.NashvilleArcgisApi.HttpClient

# disable gzip in dev
config :nashville_zone_lookup, :gzip_static, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

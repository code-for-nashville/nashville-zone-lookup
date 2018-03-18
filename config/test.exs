use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :parcel, ParcelWeb.Endpoint,
  http: [port: 4001],
  server: false

# configures mock address candidate API to use for testing
config :parcel, :nashville_arc_gis_api, Parcel.NashvilleArcgisApi.MockClient

# Print only warnings and errors during test
config :logger, level: :warn

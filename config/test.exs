use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nashville_zone_lookup, NashvilleZoneLookupWeb.Endpoint,
  http: [port: 4001],
  server: false

# configures mock address candidate API to use for testing
config :nashville_zone_lookup, :nashville_arc_gis_api, NashvilleZoneLookup.NashvilleArcgisApi.MockClient

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :nashville_zone_lookup, NashvilleZoneLookup.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "nashville_zone_lookup_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

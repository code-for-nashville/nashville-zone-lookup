ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Parcel.Repo, :manual)

# Exclude all tests that touch external systems from running by default
ExUnit.configure(exclude: [external: true])

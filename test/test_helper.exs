ExUnit.start()

# Exclude all tests that touch external systems from running by default
ExUnit.configure exclude: [external: true]

Mox.defmock(Parcel.NashvilleArcgisApi.MockClient,
  for: Parcel.NashvilleArcgisApi.Client)

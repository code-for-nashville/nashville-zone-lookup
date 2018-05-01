defmodule NashvilleZoneLookup.Repo.Migrations.UniqueZoningLandUseConditions do
  use Ecto.Migration

  def change do
    create unique_index(
      :zone_land_use_conditions,
      [:zone_id, :land_use_id],
      name: :zone_land_use_conditions_zone_id_land_use
    )
  end
end

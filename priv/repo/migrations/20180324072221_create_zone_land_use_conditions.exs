defmodule NashvilleZoneLookup.Repo.Migrations.CreateZoningDistrinctLandUseConditions do
  use Ecto.Migration

  def change do
    create table(:zone_land_use_conditions) do
      add :land_use_id, references(:land_uses, on_delete: :delete_all)
      add :land_use_condition_id, references(:land_use_conditions, on_delete: :delete_all)
      add :zone_id, references(:zones, on_delete: :delete_all)

      timestamps()
    end

    create index(:zone_land_use_conditions, [:land_use_id])
    create index(:zone_land_use_conditions, [:land_use_condition_id])
    create index(:zone_land_use_conditions, [:zone_id])
  end
end

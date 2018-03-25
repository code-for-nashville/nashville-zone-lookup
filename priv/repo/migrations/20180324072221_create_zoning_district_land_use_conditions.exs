defmodule Parcel.Repo.Migrations.CreateZoningDistrinctLandUseConditions do
  use Ecto.Migration

  def change do
    create table(:zoning_district_land_use_conditions) do
      add :land_use_id, references(:land_uses, on_delete: :delete_all)
      add :land_use_condition_id, references(:land_use_conditions, on_delete: :delete_all)
      add :zoning_district_id, references(:zoning_districts, on_delete: :delete_all)

      timestamps()
    end

    create index(:zoning_district_land_use_conditions, [:land_use_id])
    create index(:zoning_district_land_use_conditions, [:land_use_condition_id])
    create index(:zoning_district_land_use_conditions, [:zoning_district_id])
  end
end

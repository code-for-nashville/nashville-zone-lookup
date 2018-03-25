defmodule Parcel.Repo.Migrations.CreateLandUseConditions do
  use Ecto.Migration

  def change do
    create table(:land_use_conditions) do
      add :category, :string
      add :code, :string
      add :description, :string
      add :info_link, :string

      timestamps()
    end

    create unique_index(:land_use_conditions, [:code])
  end
end

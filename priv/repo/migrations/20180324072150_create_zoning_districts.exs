defmodule Parcel.Repo.Migrations.CreateZoningDistricts do
  use Ecto.Migration

  def change do
    create table(:zoning_districts) do
      add :category, :string
      add :code, :string
      add :description, :string

      timestamps()
    end

    create unique_index(:zoning_districts, [:code])
  end
end

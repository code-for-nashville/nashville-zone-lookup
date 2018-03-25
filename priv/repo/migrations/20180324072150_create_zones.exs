defmodule Parcel.Repo.Migrations.CreateZones do
  use Ecto.Migration

  def change do
    create table(:zones) do
      add :category, :string
      add :code, :string
      add :description, :string

      timestamps()
    end

    create unique_index(:zones, [:code])
  end
end

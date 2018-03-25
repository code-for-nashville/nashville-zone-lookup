defmodule Parcel.Repo.Migrations.CreateLandUses do
  use Ecto.Migration

  def change do
    create table(:land_uses) do
      add :category, :string
      add :name, :string

      timestamps()
    end

  end
end

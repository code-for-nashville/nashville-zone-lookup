defmodule NashvilleZoneLookup.Repo.Migrations.LandUseAddUniqueConstrainName do
  use Ecto.Migration

  def change do
    create unique_index(:land_uses, [:name])
  end
end

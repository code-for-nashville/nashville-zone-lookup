defmodule Parcel.Repo.Migrations.UniqueZoningLandUseConditions do
  use Ecto.Migration

  def change do
    create unique_index(
      :zoning_district_land_use_conditions,
      [:zoning_district_id, :land_use_id],
      name: :zoning_district_land_use_conditions_zoning_district_id_land_use
    )
  end
end

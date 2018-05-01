defmodule NashvilleZoneLookup.Zoning.LandUse do
  @moduledoc ~S"""
  An arrangement, activity, or input that might be undertaken on a property

  For example, a Land Use might be a class of business ("Bed and breakfast
  inn"), an agricultural activity ("Domestic hens"), or an institution
  ("Correctional facility").

  A Land Use has a `:name` that is unique. Land Uses also
  have a `:category`, such as "Residential" or "Industrial" that can be used
  to group similar Land Uses.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias NashvilleZoneLookup.Zoning.LandUse

  # Private Constants

  # These categories were manually copied from rows ending in "Uses" in
  # https://docs.google.com/spreadsheets/d/1O0Qc8nErSbstCiWpbpRQ0tPMS0NukCmcov2-s_u8Umg/edit#gid=1126820804
  @category_residential "Residential"
  @category_institutional "Institutional"
  @category_educational "Educational"
  @category_office "Office"
  @category_medical "Medical"
  @category_commercial "Commercial"
  @category_communication "Communication"
  @category_industrial "Industrial"
  @category_transportation "Transportation"
  @category_utility "Utility"
  @category_waste_management "Waste Management"
  @category_recreation_and_entertainment "Recreation and Entertainment"
  @category_other "Other"

  @categories [
    @category_residential,
    @category_institutional,
    @category_educational,
    @category_office,
    @category_medical,
    @category_commercial,
    @category_communication,
    @category_industrial,
    @category_transportation,
    @category_utility,
    @category_waste_management,
    @category_recreation_and_entertainment,
    @category_other
  ]

  schema "land_uses" do
    field(:category, :string)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(%LandUse{} = land_use, attrs) do
    land_use
    |> cast(attrs, [:category, :name])
    |> validate_required([:category, :name])
    |> validate_inclusion(:category, @categories)
    |> unique_constraint(:name)
  end

  # Public Constants

  def categories, do: @categories

  def category_residential, do: @category_residential
  def category_institutional, do: @category_institutional
  def category_educational, do: @category_educational
  def category_office, do: @category_office
  def category_medical, do: @category_medical
  def category_commercial, do: @category_commercial
  def category_communication, do: @category_communication
  def category_industrial, do: @category_industrial
  def category_transportation, do: @category_transportation
  def category_utility, do: @category_utility
  def category_waste_management, do: @category_waste_management
  def category_recreation_and_entertainment, do: @category_recreation_and_entertainment
  def category_other, do: @category_other
end

defmodule Parcel.Zoning.Zone do
  @moduledoc ~S"""
  A `Parcel.Domain.Zone` defines and limits acceptable land use for
  property within the district.

  Each Zone is assigned an alphanumeric
  `:code` that is unique. A Zone is often referred to as simply a "zone".

  While Zones are somewhat arbitrary, they usually fit into
  a pre-defined `:category`.

  A Zone may include a short textual `:description`.  This usually
  describes the type of property included in this zone and should be a
  complete sentence, as it will likely appear in the user interface.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Parcel.Zoning.Zone

  # Private Constants

  # These categories were manually copied from the column headers in
  # https://docs.google.com/spreadsheets/d/1O0Qc8nErSbstCiWpbpRQ0tPMS0NukCmcov2-s_u8Umg/edit#gid=1126820804
  @category_agricultural "Agricultural"
  @category_residential "Residential"
  @category_specific_plan "Specific Plan"
  @category_mixed_use "Mixed Use"
  @category_office "Office"
  @category_commercial "Commercial"
  @category_downtown "Downtown"
  @category_shopping_center "Shopping Center"
  @category_industrial "Industrial"

  @categories [
    @category_agricultural,
    @category_residential,
    @category_specific_plan,
    @category_mixed_use,
    @category_office,
    @category_commercial,
    @category_downtown,
    @category_shopping_center,
    @category_industrial
  ]

  schema "zones" do
    field(:category, :string)
    field(:code, :string)
    field(:description, :string)

    timestamps()
  end

  @doc false
  def changeset(%Zone{} = zone, attrs) do
    zone
    |> cast(attrs, [:category, :code, :description])
    |> validate_required([:category, :code, :description])
    |> validate_inclusion(:category, @categories)
    |> unique_constraint(:code)
  end

  # Public Constants

  def categories, do: @categories

  def category_agricultural, do: @category_agricultural
  def category_residential, do: @category_residential
  def category_specific_plan, do: @category_specific_plan
  def category_mixed_use, do: @category_mixed_use
  def category_office, do: @category_office
  def category_commercial, do: @category_commercial
  def category_downtown, do: @category_downtown
  def category_shopping_center, do: @category_shopping_center
  def category_industrial, do: @category_industrial
end

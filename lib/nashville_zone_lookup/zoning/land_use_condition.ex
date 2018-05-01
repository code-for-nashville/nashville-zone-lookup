defmodule NashvilleZoneLookup.Zoning.LandUseCondition do
  @moduledoc ~S"""
  The conditions under which a `NashvilleZoneLookup.Domain.LandUse` can be performed.

  Many `NashvilleZoneLookup.Domain.LandUse` are unconditionally permitted ("Permitted by
  right" in Nashville's terminology) for a particular
  `NashvilleZoneLookup.Domain.Zone`.  However, other `NashvilleZoneLookup.Domain.LandUse`
  are only permitted under specific conditions. For example, the Land Use
  may require approval from a zoning board, or can only be permitted withing
  an overlay district.

  A Land Use Condition is identified by a unique `:code`.
  It also includes a textual `:description` briefly describing the condition
  in a complete sentence.
  Perhaps most importantly,
  a Land Use Condition must fall into a `:category`,
  one of `[:permitted, :conditionally_permitted, :not_permitted]`.  This makes
  it simple to translate various Land Use Conditions into visual cues and
  workflows for the user.

  A Land Use Condition can optionally include an `:info_link`, a valid
  URI pointing to a more complete description of the condition.

  ## Example

      iex> %NashvilleZoneLookup.Zoning.LandUseCondition.p
      %NashvilleZoneLookup.Zoning.LandUseCondition{
        id: 1,
        category: 'permitted',
        code: "P",
        description: "Permitted by right.",
      }
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias NashvilleZoneLookup.Zoning.LandUseCondition

  # Internal Constants
  @category_conditional "conditional"
  @category_not_permitted "not_permitted"
  @category_permitted "permitted"

  @categories {@category_permitted, @category_not_permitted, @category_conditional}

  schema "land_use_conditions" do
    field(:category, :string)
    field(:description, :string)
    field(:info_link, :string)
    field(:code, :string)

    timestamps()
  end

  @doc false
  def changeset(%LandUseCondition{} = land_use_condition, attrs) do
    land_use_condition
    |> cast(attrs, [:category, :code, :description, :info_link])
    |> validate_required([:category, :code, :description])
    |> validate_inclusion(:category, @categories)
    |> unique_constraint(:code)
  end

  def land_use_condition_for_code(code) do
    %{
      "P" => p(),
      "NP" => np(),
      "PC" => pc(),
      "SE" => se(),
      "A" => a(),
      "O" => o()
    }[code]
  end

  ## Public Constants

  def p do
    %LandUseCondition{
      id: 1,
      category: @category_permitted,
      code: "P",
      description: "Permitted by right."
    }
  end

  def np do
    %LandUseCondition{
      id: 2,
      category: @category_not_permitted,
      code: "NP",
      description: "Not permitted."
    }
  end

  def pc do
    %LandUseCondition{
      id: 3,
      category: @category_conditional,
      code: "PC",
      description: "Permitted subject to certain conditions.",
      info_link:
        "https://library.municode.com/tn/metro_government_of_nashville_and_davidson_county/codes/code_of_ordinances?nodeId=CD_TIT17ZO_CH17.16LAUSDEST_ARTIIUSPECOPC"
    }
  end

  def se do
    %LandUseCondition{
      id: 4,
      category: @category_conditional,
      code: "SE",
      description: "Permitted by special exception with Board of Zoning Appeals approval.",
      info_link:
        "https://library.municode.com/tn/metro_government_of_nashville_and_davidson_county/codes/code_of_ordinances?nodeId=CD_TIT17ZO_CH17.16LAUSDEST_ARTIIIUSPESPEXSE"
    }
  end

  def a do
    %LandUseCondition{
      id: 5,
      category: @category_conditional,
      code: "A",
      description: "Permitted as accessory to principal use.",
      info_link:
        "https://library.municode.com/tn/metro_government_of_nashville_and_davidson_county/codes/code_of_ordinances?nodeId=CD_TIT17ZO_CH17.16LAUSDEST_ARTIVUSPEACA"
    }
  end

  def o do
    %LandUseCondition{
      id: 6,
      category: @category_conditional,
      code: "O",
      description: "Permitted only within an overlay district.",
      info_link:
        "https://library.municode.com/tn/metro_government_of_nashville_and_davidson_county/codes/code_of_ordinances?nodeId=CD_TIT17ZO_CH17.36OVDI"
    }
  end
end

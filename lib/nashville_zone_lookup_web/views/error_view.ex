defmodule NashvilleZoneLookupWeb.ErrorView do
  use NashvilleZoneLookupWeb, :view

  def render("400.json", assigns), do: do_render(assigns)
  def render("500.json", assigns), do: do_render(assigns)

  def render(_template, assigns) do
    render("500.json", assigns)
  end

  defp do_render(assigns), do: %{message: assigns[:message]}
end

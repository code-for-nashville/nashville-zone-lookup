defmodule ParcelWeb.ErrorView do
  use ParcelWeb, :view

  def render("400.json", _assigns) do
    %{message: "Bad request"}
  end

  def render("500.json", _assigns) do
    %{message: "Internal server error"}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end

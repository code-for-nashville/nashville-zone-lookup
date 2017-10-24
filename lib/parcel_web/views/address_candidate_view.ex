defmodule ParcelWeb.AddressCandidateView do
  use ParcelWeb, :view
  
  alias ParcelWeb.AddressCandidateView

  def render("index.json", %{address_candidates: address_candidates}) do
    %{address_candidates: render_many(address_candidates, AddressCandidateView, "address_candidate.json")}
  end

  def render("address_candidate.json", %{address_candidate: address_candidate}) do
    %{
      address: address_candidate["address"],
      score: address_candidate["score"]
    }
  end
end

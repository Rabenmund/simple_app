require 'spec_helper'

RSpec.describe OfferRepository::Create do
  subject(:create_repository) { OfferRepository::Create }

  let(:team) { create :team }
  let(:player) { create :player }

  it "creates an offer with minimal requirements" do
    offer = create_repository.create(
      player: team,
      team: player,
      reputation: 3,
      start_date: Date.today,
      end_date: Date.today + 1.day
    )
    expect(offer).to be_valid
  end
end

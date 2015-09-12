require 'spec_helper'

RSpec.describe OfferRepository::Create do
  subject(:create_repository) { OfferRepository::Create }
  it "creates an offer with minimal requirements" do
    offer = create_repository.create(
      player_id: 1,
      team_id: 2,
      reputation: 3,
      start_date: Date.today,
      end_date: Date.today + 1.day
    )
    expect(offer).to be_valid
  end
end

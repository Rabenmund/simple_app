require 'spec_helper'

RSpec.describe PlayerRepository::OfferQuery do
  subject(:query) { PlayerRepository::OfferQuery.new(player: player) }
  let(:player) { create :player }

  it "provides ids and reputations" do
    offer = create :offer, player: player, reputation: 42
    expect(query.id_and_reputations).to eq [[offer.id, 42]]
  end
end

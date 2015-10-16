require 'spec_helper'

RSpec.describe PlayerRepository::OpenOffers do
  subject(:offers) { PlayerRepository::OpenOffers }

  it "provides all players with an open offer" do
    player = create :player
    player2 = create :player
    offer = create :offer, player: player
    expect(offers.all).to eq [player]
  end
end

require 'spec_helper'

RSpec.describe PlayerRepository::CloseAllOffers do
  subject(:close) do
    PlayerRepository::CloseAllOffers.new(id: player.id)
  end
  let(:player) { create :player }

  it "sets the negotiated attr to true for all offers" do
    offer = create :offer, player: player
    close.close
    expect(offer.reload.negotiated).to eq true
  end

end

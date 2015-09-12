require 'spec_helper'

RSpec.describe PlayerRepository::Adapter do
  subject(:adapter) { PlayerRepository::Adapter.new(id: player.id) }
  let(:player) { create :player }

  it "adapts to player object" do
    expect(adapter.player).to eq player
  end

  it "adapts to human object" do
    expect(adapter.human).to eq player.human
  end

  it "provides id/reputation array for open offers" do
    offer = create :offer, player: player
    closed = create :offer, player: player, negotiated: true
    expect(adapter.offer_reputations).to eq [[offer.id, offer.reputation]]
  end
end

require 'spec_helper'

RSpec.describe TeamService::OfferForAllNeeds do
  subject("offer") do
    TeamService::OfferForAllNeeds.new(
      team: team, contract_start: :date
    )
  end

  let(:team) { double("Team", id: 1) }

  let(:players) do
    double("Players",
      keepers: :keepers,
      defenders: :defenders,
      midfielders: :midfielders,
      attackers: :attackers
    )
  end

  let(:needs) do
    {
      keepers: 1,
      defenders: 1,
      midfielders: 1,
      attackers: 1,
    }
  end

  it "places offers for all kind of needs" do

    allow(Player).to receive(:contractable_at).and_return players
    allow(TeamAdapter::Needs)
      .to receive(:new)
      .and_return double(players: needs)

    expect(TeamService::BestOffer)
      .to receive(:new)
      .with(team: team, players: :keepers, contract_start: :date)
      .and_return double(offer: double(id: 2))
    expect(TeamService::BestOffer)
      .to receive(:new)
      .with(team: team, players: :defenders, contract_start: :date)
      .and_return double(offer: double(id: 3))
    expect(TeamService::BestOffer)
      .to receive(:new)
      .with(team: team, players: :midfielders, contract_start: :date)
      .and_return double(offer: double(id: 4))
    expect(TeamService::BestOffer)
      .to receive(:new)
      .with(team: team, players: :attackers, contract_start: :date)
      .and_return double(offer: double(id: 5))
    expect(offer.offer).to eq [2,3,4,5]
  end
end

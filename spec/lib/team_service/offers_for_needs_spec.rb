require_relative '../../../lib/team_service/offers_for_needs'

RSpec.describe TeamService::OffersForNeeds do
  subject(:offer_for_needs) do
    TeamService::OffersForNeeds.new(
      team_id: 1, contract_start: :date
    )
  end

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

  let(:offer) { double("Offer") }

  it "places offers for all kind of needs" do

    allow(TeamService::Needs)
      .to receive(:new)
      .with(id: 1, date: :date)
      .and_return double("Need", players: needs)

    allow(TeamService::BestOffer)
      .to receive(:new)
      .with(id: 1, date: :date)
      .and_return offer
    expect(offer)
      .to receive(:offer_player)
      .with(type: :keeper)
      .and_return double(player_id: 2)
    expect(offer)
      .to receive(:offer_player)
      .with(type: :defender)
      .and_return double(player_id: 3)
    expect(offer)
      .to receive(:offer_player)
      .with(type: :midfielder)
      .and_return double(player_id: 4)
    expect(offer)
      .to receive(:offer_player)
      .with(type: :attacker)
      .and_return double(player_id: 5)
    expect(offer_for_needs.players).to eq [2,3,4,5]
  end
end

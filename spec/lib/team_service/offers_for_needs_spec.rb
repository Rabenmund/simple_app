require_relative '../../../lib/team_service/offers_for_needs'

RSpec.describe TeamService::OffersForNeeds do
  subject(:offer_for_needs) do
    TeamService::OffersForNeeds.new(
      id: 1, contract_start: :date
    )
  end

  let(:team_structure) { double "TeamStructure", size: 1, take_type!: :keeper }
  let(:offer) { double("Offer") }

  it "places offers for all kind of needs" do

    allow(TeamService::Needs)
      .to receive(:new)
      .with(id: 1, date: :date)
      .and_return double("Need", team_structure: team_structure)

    allow(TeamService::BestOffer)
      .to receive(:new)
      .with(id: 1, date: :date)
      .and_return offer
    expect(offer)
      .to receive(:offer_player)
      .with(type: :keeper)
      .and_return double(player_id: 2)
    expect(offer_for_needs.players).to eq [2]
  end
end

require_relative '../../../lib/team_service/offers_for_needs'
require_relative '../../../lib/team_service/needs'
require_relative '../../../lib/team_service/best_offer'

RSpec.describe TeamService::OffersForNeeds do
  subject(:offer_for_needs) do
    TeamService::OffersForNeeds.new(
      team: team, contract_start: :date
    )
  end
  let(:team) { double "Team" }
  let(:team_structure) { double "TeamStructure", size: 1, take_type!: :keeper }

  it "places offers for all kind of needs" do
    allow(TeamService::Needs)
      .to receive(:new)
      .with(team: team, date: :date)
      .and_return double("Need", team_structure: team_structure)

    allow(TeamService::BestOffer)
      .to receive(:new)
      .with(team: team, date: :date)
      .and_return(
        double("Offer", offer_player: double("Players", player: :player)))
    expect(offer_for_needs.players).to eq [:player]
  end
end

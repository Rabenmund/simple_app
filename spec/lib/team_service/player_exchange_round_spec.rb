require_relative '../../../lib/team_service/player_exchange_round'
require_relative '../../../lib/team_service/offers_for_needs'
require_relative '../../../lib/player_service/negotiate_offers'

describe TeamService::PlayerExchangeRound do

  subject(:round) do
    TeamService::PlayerExchangeRound
      .new(team_ids: team_ids, contract_start: :date)
  end

  let(:team_ids) { [1,2] }

  it "places and negotiates offers for the needs of all teams" do
    expect(TeamService::OffersForNeeds)
      .to receive(:new)
      .with(team_id: 1, contract_start: :date)
      .and_return double("Players", players: [1,3])
    expect(TeamService::OffersForNeeds)
      .to receive(:new)
      .with(team_id: 2, contract_start: :date)
      .and_return double("Players", players: [2,3])
    expect(PlayerService::NegotiateOffers)
      .to receive(:new)
      .with([1,3,2])
      .and_return double("Negotiations", negotiate: true)
    round.execute
  end
end

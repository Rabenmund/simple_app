require_relative '../../../lib/team_service/player_exchange_round'
require_relative '../../../lib/team_service/offers_for_needs'
require_relative '../../../lib/player_use_case/decide_offers'

describe TeamService::PlayerExchangeRound do

  subject(:round) do
    TeamService::PlayerExchangeRound
      .new(teams: [:team1,:team2], contract_start: :date)
  end

  it "places and negotiates offers for the needs of all teams" do
    expect(TeamService::OffersForNeeds)
      .to receive(:new)
      .with(team: :team1, contract_start: :date)
      .and_return double("Players", players: [:player1, :player2])
    expect(TeamService::OffersForNeeds)
      .to receive(:new)
      .with(team: :team2, contract_start: :date)
      .and_return double("Players", players: [:player2, :player3])
    expect(PlayerUseCase::DecideOffers)
      .to receive(:new)
      .with(player: :player1)
      .and_return double("DecideOffers", accept_best_offer: true)
    expect(PlayerUseCase::DecideOffers)
      .to receive(:new)
      .with(player: :player2)
      .and_return double("DecideOffers", accept_best_offer: true)
    expect(PlayerUseCase::DecideOffers)
      .to receive(:new)
      .with(player: :player3)
      .and_return double("DecideOffers", accept_best_offer: true)
    round.execute
  end
end

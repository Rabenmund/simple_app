require_relative '../../../lib/team_service/player_exchange_round'

describe TeamService::PlayerExchangeRound do

  subject(:round) do
    TeamService::PlayerExchangeRound
      .new(team_ids: [1,2], contract_start: :date)
  end

  it "places and negotiates offers for the needs of all teams" do
    allow(Player).to receive(:find).with(1).and_return(:player1)
    allow(Player).to receive(:find).with(2).and_return(:player2)
    allow(Player).to receive(:find).with(3).and_return(:player3)
    expect(TeamService::OffersForNeeds)
      .to receive(:new)
      .with(id: 1, contract_start: :date)
      .and_return double("Players", players: [1,3])
    expect(TeamService::OffersForNeeds)
      .to receive(:new)
      .with(id: 2, contract_start: :date)
      .and_return double("Players", players: [2,3])
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

require_relative '../../../lib/team_service/player_exchange_round'

describe TeamService::PlayerExchangeRound do

  subject(:round) do
    TeamService::PlayerExchangeRound
      .new(team_ids: [1,2], contract_start: :date)
  end

  it "places and negotiates offers for the needs of all teams" do
    expect(TeamService::OffersForNeeds)
      .to receive(:new)
      .with(team_id: 1, contract_start: :date)
      .and_return double("Players", players: [1,3])
    expect(TeamService::OffersForNeeds)
      .to receive(:new)
      .with(team_id: 2, contract_start: :date)
      .and_return double("Players", players: [2,3])
    expect(PlayerService::SelectOfferAndContract)
      .to receive(:new)
      .with(id: 1)
      .and_return double("Selection", create_contract!: true)
    expect(PlayerService::SelectOfferAndContract)
      .to receive(:new)
      .with(id: 2)
      .and_return double("Selection", create_contract!: true)
    expect(PlayerService::SelectOfferAndContract)
      .to receive(:new)
      .with(id: 3)
      .and_return double("Selection", create_contract!: true)
    round.execute
  end
end

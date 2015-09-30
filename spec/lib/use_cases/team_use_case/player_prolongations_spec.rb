require_relative '../../../../lib/use_cases/team_use_case/player_prolongations'

RSpec.describe TeamUseCase::PlayerProlongations do
  subject(:prolongations) do
    TeamUseCase::PlayerProlongations
      .new(team: team, date: date)
      .prolongate_players
  end

  let(:team) { double "Team" }
  let(:player) { double "Player", id: 1 }
  let(:date) { Date.new(2015,6,30) }
  let(:endings) { double "Endings" }
  let(:decision) { double "Decision" }

  before do
    allow(PlayerRepository::EndingContracts)
      .to receive(:new)
      .with(date: date)
      .and_return endings
    allow(TeamUseCase::PlayerContractDecision)
      .to receive(:new)
      .with(team: team, player: player, date: date)
      .and_return decision
  end

  it "prolongates a players contract" do
    allow(endings)
      .to receive(:for_team)
      .with(team)
      .and_return [player]
    allow(decision)
      .to receive(:decide!)
      .and_return true
    expect(TeamUseCase::CreatePlayerOffer)
      .to receive(:at)
      .with(team: team, player: player, date: date)
    expect(prolongations).to eq [player.id]
  end

  it "does not prolongate a players contract if he isnt wanted" do
    allow(endings)
      .to receive(:for_team)
      .with(team)
      .and_return [player]
    allow(decision)
      .to receive(:decide!)
      .and_return false
    expect(TeamUseCase::CreatePlayerOffer)
      .to_not receive(:at)
    expect(prolongations).to eq []

  end

  it "does not prolongate players having no ending contract" do
    allow(endings)
      .to receive(:for_team)
      .with(team)
      .and_return []
    expect(prolongations).to eq []
  end
end

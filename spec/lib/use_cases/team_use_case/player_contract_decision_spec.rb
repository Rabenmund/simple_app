require_relative '../../../../lib/use_cases/team_use_case/player_contract_decision'

RSpec.describe TeamUseCase::PlayerContractDecision do
  let(:team) { double("Team") }
  let(:player) { double("Player", strength: 300, type: :attacker, age: 25) }
  let(:date) { Date.new(2015,7,1) }
  let(:query) { double "PlayerQuery", avg_at: 200, type_avg_at: 100 }

  subject(:decision) do
    TeamUseCase::PlayerContractDecision
      .new(team: team, player: player, date: date)
  end

  before do
    allow(TeamRepository::PlayerQuery)
      .to receive(:new)
      .with(team: team)
      .and_return query
  end

  it "decides successfully for players being better as team" do
    expect(decision.decide!).to eq true
  end

  it "decides successfully for players being clearly better as peers" do
    allow(player).to receive(:strength).and_return 150
    expect(decision.decide!).to eq true
  end

  it "decides successfully for prospering young players" do
    allow(player).to receive(:strength).and_return 80
    allow(player).to receive(:age).and_return 18
    expect(decision.decide!).to eq true
  end

  it "decides negatively for players being not good enough" do
    allow(player).to receive(:strength).and_return 80
    expect(decision.decide!).to eq false
  end

end

require_relative '../../../../lib/use_cases/team_use_case/player_contract_decision'

RSpec.describe TeamUseCase::PlayerContractDecision do
  let(:team) { double("Team") }
  let(:player) do
    double("Player", main_strength: 300, main_type: :attacker, human: :human)
  end
  let(:date) { Date.new(2015,7,1) }
  let(:query) { double "PlayerQuery", avg_at: 200, type_avg_at: 100 }
  let(:age) { double("Age") }

  subject(:decision) do
    TeamUseCase::PlayerContractDecision
      .new(team: team, player: player, date: date)
  end

  before do
    allow(TeamRepository::PlayerQuery)
      .to receive(:new)
      .with(team: team)
      .and_return query
    allow(HumanRepository::Age)
      .to receive(:new)
      .and_return age
    allow(age)
      .to receive(:age_at)
      .and_return 25
  end

  it "decides successfully for players being better as team" do
    expect(decision.decide!).to eq true
  end

  it "decides successfully for players being clearly better as peers" do
    allow(player).to receive(:main_strength).and_return 150
    expect(decision.decide!).to eq true
  end

  it "decides successfully for prospering young players" do
    allow(player).to receive(:main_strength).and_return 80
    allow(age)
      .to receive(:age_at)
      .and_return 18
    expect(decision.decide!).to eq true
  end

  it "decides negatively for players being not good enough" do
    allow(player).to receive(:main_strength).and_return 80
    expect(decision.decide!).to eq false
  end

end

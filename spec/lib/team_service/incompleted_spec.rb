require_relative '../../../lib/team_service/incompleted'
require_relative '../../../lib/team_structure'
require_relative '../../../lib/team_service/needs'

describe TeamService::Incompleted do

  subject(:incompleted) do
    TeamService::Incompleted.new(teams: [:team1,:team2], date: date)
  end
  let(:date) { Date.new(2015,7,1) }

  it "keeps all incomplete teams" do
    allow(TeamService::Needs)
      .to receive(:new)
      .with(team: :team1, date: date)
      .and_return double(team_structure: TeamStructure.new(0,0,0,0))
    allow(TeamService::Needs)
      .to receive(:new)
      .with(team: :team2, date: date)
      .and_return double(team_structure: TeamStructure.new(1,1,1,1))
    expect(incompleted.need_players).to eq [:team2]
  end
end

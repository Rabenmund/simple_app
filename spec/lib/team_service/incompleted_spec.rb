require_relative '../../../lib/team_service/incompleted'
require_relative '../../../lib/team_structure'

describe TeamService::Incompleted do

  subject(:incompleted) do
    TeamService::Incompleted.new(ids: [1,2], date: date)
  end
  let(:date) { Date.new(2015,7,1) }

  it "keeps all incomplete teams" do
    allow(TeamService::Needs)
      .to receive(:new)
      .with(id: 1, date: date)
      .and_return double(players: TeamStructure.new(0,0,0,0))
    allow(TeamService::Needs)
      .to receive(:new)
      .with(id: 2, date: date)
      .and_return double(players: TeamStructure.new(1,1,1,1))
    expect(incompleted.teams).to eq [2]
  end
end

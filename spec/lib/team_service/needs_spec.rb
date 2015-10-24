require_relative '../../../lib/team_service/needs'
require_relative '../../../lib/team_repository/current_team_structure'
require_relative '../../../lib/team_structure'

RSpec.describe TeamService::Needs do
  subject(:needs) { TeamService::Needs.new(team: team, date: date) }
  let(:team) { double "Team" }
  let(:date) { DateTime.now }

  it "provides a team_structure of needed players" do
    allow(TeamRepository::CurrentTeamStructure)
      .to receive(:current_team_structure)
      .with(team: team, date: date)
      .and_return TeamStructure.new(1,2,3,4)
    expect(needs.team_structure).to eq TeamStructure.new(2,6,5,0)
  end
end

require_relative '../../../lib/team_service/needs'

RSpec.describe TeamService::Needs do
  subject(:needs) { TeamService::Needs.new(id: 1, date: date) }
  let(:date) { DateTime.now }

  it "provides a team_structure of needed players" do
    allow(TeamRepository::CurrentTeamStructure)
      .to receive(:current_team_structure)
      .with(id: 1, date: date)
      .and_return TeamStructure.new(1,2,3,4)
    expect(needs.team_structure).to eq TeamStructure.new(2,6,5,0)
  end
end

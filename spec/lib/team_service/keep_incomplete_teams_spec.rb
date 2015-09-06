require_relative '../../../lib/team_service/keep_incomplete_teams'
require_relative '../../../lib/team_service/needed_players'

describe TeamService::KeepIncompleteTeams do

  let(:complete) { double("TeamComplete") }
  let(:incomplete) { double("TeamIncomplete") }
  subject { TeamService::KeepIncompleteTeams }

  it "keeps all incomplete teams" do
    allow(TeamService::NeededPlayers)
      .to receive(:new)
      .with(complete)
      .and_return double(need: 0)
    allow(TeamService::NeededPlayers)
      .to receive(:new)
      .with(incomplete)
      .and_return double(need: 1)
    teams = [complete, incomplete]
    expect(subject.keep(teams)).to eq [incomplete]
  end
end

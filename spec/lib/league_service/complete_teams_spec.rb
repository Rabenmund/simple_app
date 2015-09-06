require_relative '../../../lib/league_service/complete_teams.rb'
require_relative '../../../lib/league_service/player_negotiation_round.rb'

describe LeagueService::CompleteTeams do

  let(:complete) { double("TeamComplete", need: 0) }
  let(:incomplete) { double("TeamIncomplete", need: 1) }
  let(:incomplete2) { double("TeamIncomplete2", need: 23) }
  let(:league) do
    double("League",
           teams: [complete, incomplete, incomplete2],
           start: date)
  end
  let(:date) { DateTime.now }

  subject { LeagueService::CompleteTeams.new(league) }

  it "complete all league teams with players" do
    allow(TeamService::KeepIncompleteTeams)
      .to receive(:kept)
      .and_return [incomplete, incomplete2], []
    expect(LeagueService::PlayerNegotiationRound)
      .to receive(:execute)
      .with(teams: [incomplete, incomplete2], contract_date: date)
    subject.complete
  end
end

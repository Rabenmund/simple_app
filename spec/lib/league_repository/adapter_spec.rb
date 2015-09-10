require 'spec_helper'

RSpec.describe LeagueRepository::Adapter do
  subject(:adapter) { LeagueRepository::Adapter.new(id: league.id) }
  let(:league) { create :league }

  it "provides the team ids" do
    team1 = create :team
    team2 = create :team
    league.teams.concat [team1, team2]
    expect(adapter.team_ids.sort).to eq [team1.id, team2.id]
  end

  it "provides a start_date" do
    expect(adapter.start_date).to eq league.start
  end
end

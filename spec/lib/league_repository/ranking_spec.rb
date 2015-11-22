require 'spec_helper'

RSpec.describe LeagueRepository::Ranking do
  subject(:ranking) { LeagueRepository::Ranking.new(league: league) }
  let(:league) { create :league }
  let(:team1) { create :team }
  let(:team2) { create :team }
  let(:team3) { create :team }
  let!(:result1) { create :result, rank: 1, league: league, team: team1 }
  let!(:result2) { create :result, rank: 2, league: league, team: team2 }
  let!(:result3) { create :result, rank: 3, league: league, team: team3 }

  before do
    league.teams << team1 << team2 << team3
  end

  it "find the first number of leading teams in ranking" do
    expect(ranking.first(2)).to include team1
    expect(ranking.first(2)).to include team2
  end

  it "finds the last number of leading teams in ranking" do
    expect(ranking.last(2)).to include team3
    expect(ranking.last(2)).to include team2
  end

  it "finds teams from..to a specific ranking place" do
    expect(ranking.from(2,1)).to eq [team2]
  end
end

require 'spec_helper'

RSpec.describe SeasonRepository::Adapter do
  subject(:repo) { SeasonRepository::Adapter.new(id: season.id) }
  let(:season) { create :season }

  it "provides league_ids" do
    league1 = create :league, season: season, level: 2
    league2 = create :league, season: season, level: 1
    expect(repo.league_ids).to eq [league2.id, league1.id]
  end

  it "provides team ids of all teams belonging to a season" do
    team = create :team
    league = create :league, season: season
    league.teams << team
    expect(repo.team_ids).to eq [team.id]
  end

  it "provides a start_date" do
    expect(repo.start_date).to eq season.start_date
  end
end

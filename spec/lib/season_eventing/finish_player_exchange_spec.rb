require 'spec_helper'

RSpec.describe SeasonEventing::FinishPlayerExchange do
  subject(:finisher) do
    SeasonEventing::FinishPlayerExchange.new(season: season)
  end
  let!(:season) { create :season }
  let!(:league1) { create :league, season: season }
  let!(:league2) { create :league, season: season }
  let!(:cup1) { create :cup, season: season }
  let!(:team1) { create :team }
  let!(:team2) { create :team }
  let!(:team3) { create :team }
  let!(:team4) { create :team }

  before do
    league1.teams << team1
    league2.teams << team2
    cup = create :cup, season: season
    cup.teams << team3
  end

  it "fills up all teams with players by league" do
    allow(TeamService::FillUp)
      .to receive(:new)
      .and_return double fill_up: true
    expect(LeagueService::FillUpTeams)
      .to receive(:new)
      .with(league: league1)
      .and_return double("FillUp", fill_up: true)
    expect(LeagueService::FillUpTeams)
      .to receive(:new)
      .with(league: league2)
      .and_return double("FillUp", fill_up: true)
    finisher.call
  end

  it "fills up all teams with players despite league" do
    expect(season.teams.count).to eq 3
    expect(Team.all.count).to eq 4
    expect(TeamService::FillUp)
      .to receive(:new)
      .with(teams: season.teams, start_date: season.start_date)
      .and_return double("FillUp", fill_up: true)
    allow(LeagueService::FillUpTeams)
      .to receive(:new)
      .and_return double fill_up: true
    finisher.call
  end

end

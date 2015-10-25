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

  it "fills up all teams with players by league and without" do
    expect(TeamService::FillUp)
      .to receive(:new)
      .with(teams: [team1], start_date: season.start_date)
      .and_return double fill_up: true
    expect(TeamService::FillUp)
      .to receive(:new)
      .with(teams: [team2], start_date: season.start_date)
      .and_return double fill_up: true
    expect(TeamService::FillUp)
      .to receive(:new)
      .with(teams: season.teams, start_date: season.start_date)
      .and_return double fill_up: true
    finisher.call
  end

end

require 'spec_helper'

RSpec.describe LeagueRepository::LeagueCreator do
  subject(:creator) { described_class.new(league_attributes) }
  let(:season) { create :season }
  let(:league) { build :league, season: season }
  let(:league_attributes) { league.attributes.merge(id: nil)}
  let(:team1) { create :team }
  let(:team2) { create :team }

  it "builds a league by given attributes" do
    expect(creator.league).to be_a League
  end

  it "adds teams to the league" do
    new_league = creator.league
    creator.add_teams [team1, team2]
    expect(new_league.teams).to contain_exactly team1, team2
  end

  it "ensures the correct team size" do
    new_league = creator.league
    expect(LeagueUseCase::FillUpWithTeams)
      .to receive(:new)
      .with(league: new_league, size: 18)
      .and_return(double("FillUp", random: :random))
    expect(creator.ensure_team_size(18)).to eq :random
  end

  it "plans the games according to the teams" do
    new_league = creator.league
    expect(CompetitionUseCase::GamesPlanner)
      .to receive(:new)
      .with(competition: new_league, type: :league)
      .and_return(double("GamePlanner", call: true))
    new_league = creator.plan_games_for([team1, team2])
  end
end

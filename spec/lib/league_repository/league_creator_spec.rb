require 'spec_helper'

RSpec.describe LeagueRepository::LeagueCreator do
  subject(:creator) { described_class.new(league_attributes) }
  let(:season) { create :season }
  let(:league) { create :league, season: season }
  let(:league_attributes) { league.attributes.merge(id: nil)}
  let(:team1) { create :team }
  let(:team2) { create :team }

  it "builds a league by given attributes" do
    expect(creator.league).to be_a League
  end

  it "adds all teams to a created league" do
    new_league = creator.invoke_with_teams([team1, team2])
    expect(new_league.teams).to include team1
    expect(new_league.teams).to include team2
  end
end

require 'spec_helper'

RSpec.describe TeamRepository::AvailableForLeague do
  subject(:teams) { described_class.new(league: league1) }
  let(:season) { create :season }
  let(:federation) { create :federation }
  let(:league1) { create :league, season: season, federation: federation }
  let(:league2) { create :league, season: season, federation: federation }
  let(:team1) { create :team }
  let(:team2) { create :team }
  let(:team3) { create :team }

  before do
    federation.teams << team1 << team2 << team3
    league1.teams << team1
    league2.teams << team2
  end

  it "finds the available teama randomly" do
    expect(teams.random(1)).to eq [team3]
  end

  it "raises an error if not enough teams available" do
    expect{teams.random(2)}.to raise_error TeamRepository::NotEnoughTeamsError
  end
end

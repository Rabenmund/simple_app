require 'spec_helper'

RSpec.describe LeagueRepository::Superleague do
  subject(:superleague_find) { LeagueRepository::Superleague.find_for(league) }
  let(:league) { create :league, level: 2 }

  it "finds for a league the super league" do
    superleague = create :league, level: 1, season: league.season
    expect(superleague_find).to eq superleague
  end
end

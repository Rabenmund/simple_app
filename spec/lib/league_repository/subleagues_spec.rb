require 'spec_helper'

RSpec.describe LeagueRepository::Subleagues do
  subject(:subleagues) { LeagueRepository::Subleagues.find_all_for(league) }
  let(:league) { create :league, level: 1 }

  it "finds all subleagues for a league" do
    sub1 = create :league, season: league.season, level: 2
    sub2 = create :league, season: league.season, level: 2
    expect(subleagues).to include sub1
    expect(subleagues).to include sub2
    expect(subleagues.size).to eq 2
  end
end

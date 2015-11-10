require 'spec_helper'

RSpec.describe LeagueRepository::Finder do
  subject(:finder) { described_class }

  it "finds a league in a previous season by name" do
    season = create :season
    league = create :league, season: season
    expect(finder.by_name(season: season, name: league.name))
      .to eq league
  end
end

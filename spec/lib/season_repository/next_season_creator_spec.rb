require 'spec_helper'

RSpec.describe SeasonRepository::NextSeasonCreator do
  subject(:creator) { SeasonRepository::NextSeasonCreator.new(season: season) }
  let(:season) { create :season }

  it "creates the next season" do
    next_season = creator.create
    expect(season.next_one).to eq next_season
  end

  it "does not create a next season if there is already one" do
    create :season, year: season.year + 1
    expect(creator.create).to be_nil
  end
end

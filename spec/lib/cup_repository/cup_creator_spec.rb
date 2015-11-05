require 'spec_helper'

RSpec.describe CupRepository::CupCreator do
  subject(:creator) do
    CupRepository::CupCreator.new(season: season, previous: previous)
  end
  let(:season) do
    create :season,
      year: 2016,
      start_date: Date.new(2015, 7, 1),
      end_date: Date.new(2016, 6, 30)
  end
  let(:previous) do
    create :season,
      year: 2015,
      start_date: Date.new(2014, 7, 1),
      end_date: Date.new(2015, 6, 30)
  end

  it "does anything"
end


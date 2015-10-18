require 'spec_helper'

RSpec.describe SeasonEventing::HalfTimeCreator do
  subject(:creator) { SeasonEventing::HalfTimeCreator }
  let(:season) { create :season }

  it "creates a half time event and appoints it" do
    creator.for_season season
    event = SeasonEventing::HalfTime.last
    expect(event).to be_valid
    expect(event.appointed_at).to eq Date.new(season.start_date.year, 12, 31)
  end
end

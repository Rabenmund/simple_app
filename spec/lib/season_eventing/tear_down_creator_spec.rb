require 'spec_helper'

RSpec.describe SeasonEventing::TearDownCreator do
  let(:season) { create :season }

  it "creates a tear down event and appoint it" do
    SeasonEventing::TearDownCreator.for_season season
    event = SeasonEventing::TearDown.last
    expect(event).to be_valid
    expect(event.appointed_at).to eq season.end_date
  end
end

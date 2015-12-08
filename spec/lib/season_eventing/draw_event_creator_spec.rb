require 'spec_helper'

RSpec.describe SeasonEventing::DrawEventCreator do
  subject(:creator) { SeasonEventing::DrawEventCreator }

  let(:season) { create :season }
  let(:draw) { create :draw }
  let(:date) { Date.new(2015,12,1) }

  it "creates a game event with appointment" do
    event = creator.create(season: season, eventable: draw, appointed_at: date)
    expect(event).to be_valid
    expect(event.appointed_at).to eq date
  end
end

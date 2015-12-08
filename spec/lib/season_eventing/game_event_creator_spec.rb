require 'spec_helper'

RSpec.describe SeasonEventing::GameEventCreator do
  subject(:creator) { SeasonEventing::GameEventCreator }

  let(:season) { create :season }
  let(:game) { create :game }
  let(:date) { Date.new(2015,12,1) }

  it "creates a game event with appointment" do
    event = creator.create(season: season, eventable: game, appointed_at: date)
    expect(event).to be_valid
    expect(event.appointed_at).to eq date
  end
end

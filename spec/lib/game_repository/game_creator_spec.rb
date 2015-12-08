require 'spec_helper'

RSpec.describe GameRepository::GameCreator do
  subject(:creator) { described_class }
  let(:game) { build :game }
  let(:attributes) { game.attributes }
  let(:date) { Date.new(2015,7,1) }

  it "creates a game including the game event" do
    game = creator.create(date: date, attributes: attributes)
    expect(game).to be_a Game
    expect(game).to be_valid
    expect(game.season_event).to be_a SeasonEvent
    expect(game.season_event.appointed_at).to eq date
    expect(SeasonEvent.all.count).to eq 1
  end
end

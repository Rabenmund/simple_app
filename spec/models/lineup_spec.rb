require 'spec_helper'

describe Lineup do

  let(:game) { create :game }
  let(:lineup) { create :lineup, game: game, team: game.home }

  it "is valid" do
    expect(lineup).to be_valid
  end
end

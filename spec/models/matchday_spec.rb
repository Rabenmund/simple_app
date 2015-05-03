require 'spec_helper'

describe Matchday do

  let(:matchday) { create :matchday }
  let(:game) { create :game, matchday: matchday }

  it "is valid" do
    expect(matchday).to be_valid
  end

  it "has games" do
    game
    expect(matchday.has_games?).to eq true
  end

  it "is not finished without games" do
    expect(matchday.finished?).to eq false
  end

  it "is not finished without all games finished" do
    game
    expect(matchday.finished?).to eq false
  end

  it "is finished with all games finished" do
    game.update_attributes(home_goals: 1, guest_goals: 0)
    game.finish!
    expect(matchday.finished?).to eq true
  end

end

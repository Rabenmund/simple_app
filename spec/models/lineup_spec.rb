require 'spec_helper'

describe Lineup do

  let(:game) { create :game }
  let(:team) { game.home }
  let(:lineup) { create :lineup, game: game, team: team }
  let(:system) { { keepers: 1, defenders: 4, midfielders: 4, attackers: 2 } }

  before do
    allow(lineup).to receive(:system).and_return system
    create :keeper
    4.times { create :defender }
    4.times { create :midfielder }
    2.times { create :attacker }
    allow(team).to receive(:players).and_return Player.all
  end

  it "is valid" do
    expect(lineup).to be_valid
  end

  it "sets up a lineup" do
    lineup.start!
    expect(lineup.actors.count).to eq 11
    expect(lineup.initiative).to eq 1500
    expect(lineup.defending).to eq 1800
    expect(lineup.attacking).to eq 1100
  end

  it "sets up less than needed players" do
    Player.last.delete
    lineup.start!
    expect(lineup.players.count).to eq 10
  end

  it "multiple calls of set reset actors entirely" do
    Player.last.delete
    lineup.start!
    create :player
    lineup.reload
    allow(lineup).to receive(:players).and_return Player.all
    lineup.reset!
    expect(lineup.players.count).to eq 11
  end

end

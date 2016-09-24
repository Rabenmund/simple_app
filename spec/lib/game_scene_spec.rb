require 'spec_helper'

describe GameScene do

  let(:home) { double initiative: 100, attacking: 100 }
  let(:guest) { double initiative: 0, defending: 0, attacking: 100  }
  let(:game) { create :game  }
  let(:scene) do
    GameScene.new(
      game: game,
      home_lineup: game.home_lineup,
      guest_lineup: game.guest_lineup
    )
  end

  before do
    allow(game).to receive(:home_lineup).and_return home
    allow(game).to receive(:guest_lineup).and_return guest
  end

  it "performs a game event with a goal" do
    scene.perform
    expect(game.home_goals).to eq 1
  end

  it "performs a game event with no goal" do
    allow(home).to receive(:attacking).and_return 0
    allow(guest).to receive(:defending).and_return 100
    allow(scene).to receive(:goal_for_home?).and_return false
    expect(scene.perform).to eq nil
  end
end

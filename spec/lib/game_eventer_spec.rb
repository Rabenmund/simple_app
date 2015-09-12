require 'spec_helper'

describe GameEventer do

  let(:home) { double initiative: 100, attacking: 100 }
  let(:guest) { double initiative: 0, defending: 0, attacking: 100  }
  let(:game) { create :game  }
  let(:event) { GameEventer.new(game) }

  before do
    allow(game).to receive(:home_lineup).and_return home
    allow(game).to receive(:guest_lineup).and_return guest
  end

  # it "performs a game event with a goal" do
  #   event.goal_event
  #   expect(game.home_goals).to eq 1
  # end

  # it "performs a game event with no goal" do
  #   allow(home).to receive(:attacking).and_return 0
  #   allow(guest).to receive(:defending).and_return 100
  #   allow(event).to receive(:goal_for_home?).and_return false
  #   expect(event.goal_event).to eq nil
  # end
end

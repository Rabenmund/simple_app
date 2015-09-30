require 'spec_helper'

RSpec.describe PlayerRepository::Updater do
  subject(:updater) { PlayerRepository::Updater.new(player: player) }
  let(:player) { create :player, keeper: 100, defense: 105 }

  it "retires a player" do
    expect{updater.retire!}.to change{player.reload.retired}.from(false).to(true)
  end
end

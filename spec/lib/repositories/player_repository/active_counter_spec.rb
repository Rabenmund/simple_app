require 'spec_helper'

RSpec.describe PlayerRepository::ActiveCounter do
  let(:date) { Date.new(2015,7,1) }

  before do
    @player1 = create :player
    @player2 = create :player, retired: true
    @player3 = create :player
    create :contract,
      human: @player3.human,
      from: date - 1.year,
      to: date
  end

  it "counts the active players at a date" do
    expect(PlayerRepository::ActiveCounter.at(date))
      .to eq 2
  end
end

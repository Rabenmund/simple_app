require 'spec_helper'

RSpec.describe PlayerRepository::ContractedFinder do
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

  it "finds all contracted players at a date" do
    expect(PlayerRepository::ContractedFinder.at(date))
      .to eq [@player3]
  end
end


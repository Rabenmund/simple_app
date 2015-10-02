require 'spec_helper'

RSpec.describe PlayerRepository::OldPlayers do
  subject(:old_players) { PlayerRepository::OldPlayers }
  let(:year) { 2015 }

  it "finds old players" do
    old_human = create :human, birthday: Date.new(year-1)
    old = create :player, human: old_human
    young_human = create :human, birthday: Date.new(year)
    young = create :player, human: young_human
    expect(old_players.find_at(birthyear: year)).to eq [old]
  end

end


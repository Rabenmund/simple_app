require 'spec_helper'

RSpec.describe PlayerRepository::Age do
  subject(:age) { PlayerRepository::Age }
  let(:year) { 2015 }

  it "finds old players" do
    old_human = create :human, birthday: Date.new(year-1)
    old = create :player, human: old_human
    young_human = create :human, birthday: Date.new(year)
    young = create :player, human: young_human
    expect(age.old_players(birthyear: year)).to eq [old]
  end

end


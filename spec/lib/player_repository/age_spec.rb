require 'spec_helper'

RSpec.describe PlayerRepository::Age do
  subject(:age) { PlayerRepository::Age }
  let(:year) { 2015 }

  it "finds old players" do
    old_human = create :human, birthday: Date.new(year-1)
    old = create :player, human: old_human
    young_human = create :human, birthday: Date.new(year)
    young = create :player, human: young_human
    expect(age.old_players(birthyear: year)).to eq [old.id]
  end

  it "provides a players count of years over a specific birthyear" do
    human = create :human, birthday: Date.new(1969)
    player = create :player, human: human
    expect(age.years_over(id: player.id, birthyear: year)).to eq 46
  end

  it "returns a 0 if the count is negative" do
    human = create :human, birthday: Date.new(2016)
    player = create :player, human: human
    expect(age.years_over(id: player.id, birthyear: year)).to eq 0
  end

end


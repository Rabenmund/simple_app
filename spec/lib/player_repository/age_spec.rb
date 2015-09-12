require 'spec_helper'

RSpec.describe PlayerRepository::Age do
  subject(:age) { PlayerRepository::Age.new(year: year) }
  let(:year) { 2015 }

  it "finds old players" do
    old_human = create :human, birthday: Date.new(year-31,3,31)
    old = create :player, human: old_human
    young_human = create :human, birthday: Date.new(year-30,3,31)
    young = create :player, human: young_human
    expect(age.old).to eq [old]
  end

end


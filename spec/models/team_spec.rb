require 'spec_helper'

describe Team do

  subject(:team) { create :team }
  let(:date) { Date.new(2015,7,1) }
  let(:player) { create :player }

  it { should be_valid }

  it "has players at a date" do
    create :contract, human: player.human, organization: team.organization,
      from: date, to: date+1.year
    expect(team.players_at(date)).to include player
  end

  it "does not have former players" do
    create :contract, human: player.human, organization: team.organization,
      from: date-1.year, to: date-1.day
    expect(team.players_at(date)).to_not include player
  end

end

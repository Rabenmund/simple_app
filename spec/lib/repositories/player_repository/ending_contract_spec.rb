require 'spec_helper'

RSpec.describe PlayerRepository::EndingContracts do
  subject(:players) do
    PlayerRepository::EndingContracts.new(date: to).for_team(team)
  end

  let(:team) { create :team }
  let(:from) { Date.new(2014,7,1) }
  let(:to) { Date.new(2015,7,1) }

  it "finds players with ending contracts" do
    player = create :player
    create :contract,
      human: player.human,
      organization: team.organization,
      from: from,
      to: to
    expect(players).to include player
  end

  it "does not find players without ending contracts" do
    player = create :player
    create :contract,
      human: player.human,
      organization: team.organization,
      from: from,
      to: to
    allow(self).to receive(:to).and_return (to - 1.day)
    expect(players).to_not include player
  end

end

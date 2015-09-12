require 'spec_helper'

RSpec.describe TeamRepository::Players do
  subject(:players) { TeamRepository::Players.new(id: team.id) }

  let(:team) { create :team }
  let(:date) { DateTime.new(2015,7,1) }

  it "has keepers" do
    keeper = create :keeper
    create :contract,
      human: keeper.human, organization: team.organization,
      from: date-1.day, to: date+1.day
    expect(players.size(type: :keepers, date: date)).to eq 1
  end

  it "provides the number of all players" do
    player = create :player
    create :contract, human: player.human, organization: team.organization,
      from: date, to: date
    expect(players.all_types_size(date: date)).to eq 1
  end

end

require 'spec_helper'

RSpec.describe TeamQuery::Players do
  subject(:team_players) { TeamQuery::Players.new(id: team.id) }

  let(:team) { create :team }
  let(:date) { DateTime.now }

  before do
    @organization = create :organization, organizable: team
  end

  it "has keepers" do
    keeper = create :keeper
    create :contract, human: keeper.human, organization: @organization
    expect(team_players.size(type: :keepers, date: date)).to eq 1
  end

end

require 'spec_helper'

RSpec.describe TeamRepository::Reputation do
  subject(:reputation) { TeamRepository::Reputation.new(team.id) }
  let(:team) { create :team, reputation: 100 }

  it "has a reputation" do
    expect(reputation.reputation).to eq 100
  end

  it "calculates and sets a new reputation" do
    expect(reputation.reset!).to eq 100
  end
end

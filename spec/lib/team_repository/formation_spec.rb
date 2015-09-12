require 'spec_helper'

RSpec.describe TeamRepository::Formation do
  subject(:formation) { TeamRepository::Formation.new(id: 1) }

  let(:team) { double("Team") }

  before { allow(Team).to receive(:find).and_return team }

  it "has a formation" do
    expect(formation.formation).to eq({
      keepers: 1.5,
      defenders: 4,
      midfielders: 4,
      attackers: 2
    })
  end
end

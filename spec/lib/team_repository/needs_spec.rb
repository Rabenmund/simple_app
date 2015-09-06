require 'spec_helper'

RSpec.describe TeamRepository::Needs do
  let(:team) { create :team }
  let(:date) { DateTime.now }
  let(:need) { double("Needs") }

  let(:formation) do
    {
      keepers: 1.5,
      defenders: 4,
      midfielders: 4,
      attackers: 2
    }
  end

  subject(:needs) { TeamRepository::Needs.new(id: team.id, date: date) }

  it "returns a hash with player types" do
    allow(TeamRepository::Formation)
      .to receive(:new)
      .with(id: team.id)
      .and_return double(formation: formation)
    allow(TeamQuery::Players)
      .to receive(:new)
      .with(id: team.id)
      .and_return need
    allow(need).to receive(:size)
      .with(type: :keepers, date: date)
      .and_return 1
    allow(need).to receive(:size)
      .with(type: :defenders, date: date)
      .and_return 3
    allow(need).to receive(:size)
      .with(type: :midfielders, date: date)
      .and_return 1
    allow(need).to receive(:size)
      .with(type: :attackers, date: date)
      .and_return 1
    expect(needs.players).to eq({
      keepers: 2,
      defenders: 5,
      midfielders: 7,
      attackers: 3
    })
  end

end

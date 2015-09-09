require_relative '../../../lib/team_service/needs'
require_relative '../../../lib/team_repository/formation'
require_relative '../../../lib/team_repository/players'

RSpec.describe TeamService::Needs do
  let(:date) { DateTime.now }
  let(:repo) { double("Repo") }

  let(:formation) do
    {
      keepers: 1.5,
      defenders: 4,
      midfielders: 4,
      attackers: 2
    }
  end

  subject(:needs) { TeamService::Needs.new(id: 1, date: date) }

  before do
    allow(TeamRepository::Players)
      .to receive(:new)
      .with(id: 1)
      .and_return repo
    allow(TeamRepository::Formation)
      .to receive(:new)
      .with(id: 1)
      .and_return double(formation: formation)
  end

  it "returns a hash with player types" do
    allow(repo).to receive(:size)
      .with(type: :keepers, date: date)
      .and_return 1
    allow(repo).to receive(:size)
      .with(type: :defenders, date: date)
      .and_return 3
    allow(repo).to receive(:size)
      .with(type: :midfielders, date: date)
      .and_return 1
    allow(repo).to receive(:size)
      .with(type: :attackers, date: date)
      .and_return 1
    expect(needs.players).to eq({
      keepers: 2,
      defenders: 5,
      midfielders: 7,
      attackers: 3
    })
  end

  it "tells wether players are needed at all" do
    allow(repo)
      .to receive(:all_types_size)
      .and_return 23
    expect(needs.players?).to eq false
    allow(repo)
      .to receive(:all_types_size)
      .and_return 22
    expect(needs.players?).to eq true
  end

end

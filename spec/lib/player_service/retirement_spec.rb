require_relative '../../../lib/player_service/retirement'

RSpec.describe PlayerService::Retirement do
  subject(:retirement) do
    PlayerService::Retirement.new(id: 1, birthyear: 2015)
  end

  it "retires a player" do
    allow(PlayerRepository::Age)
      .to receive(:years_over)
      .and_return 5
    allow(retirement)
      .to receive(:rand)
      .and_return 1
    expect(PlayerRepository::Adapter)
      .to receive(:new)
      .with(id: 1)
      .and_return double("Retire!", retire!: true)
    expect(retirement.retire?).to eq true
  end

  it "does not retire a player" do
    allow(PlayerRepository::Age)
      .to receive(:years_over)
      .and_return 5
    allow(retirement)
      .to receive(:rand)
      .and_return 100
    expect(PlayerRepository::Adapter)
      .to_not receive(:new)
    expect(retirement.retire?).to eq false
  end

end

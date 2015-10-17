require_relative '../../../lib/player_use_case/retirement'

RSpec.describe PlayerUseCase::Retirement do
  subject(:retirement) do
    PlayerUseCase::Retirement.new(player: player, year: 2030)
  end
  let(:player) { double("Player", birthday: Date.new(1990,1,1)) }

  it "retires a player" do
    expect(PlayerRepository::Updater)
      .to receive(:new)
      .with(player: player)
      .and_return double("Retire!", retire!: true)
    expect(retirement.retire?).to eq true
  end

  it "does not retire a player" do
    allow(player)
      .to receive(:birthday)
      .and_return(Date.new(2010,1,1))
    expect(PlayerRepository::Updater)
      .to_not receive(:new)
    expect(retirement.retire?).to eq false
  end
end

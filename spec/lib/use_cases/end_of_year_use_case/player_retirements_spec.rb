require 'spec_helper' # don't know where to find rails class for + years

RSpec.describe EndOfYearUseCase::PlayerRetirements do
  subject(:retirements) do
    EndOfYearUseCase::PlayerRetirements.new(year: 2015)
  end

  let(:date) { Date.new(2015,7,1) }
  let(:player) { double("Player", id: 1) }

  it "asks old players whether to retire" do
    expect(PlayerRepository::OldPlayers)
      .to receive(:active_and_born_in)
      .with(birthyear: 2015)
      .and_return [player]
    retire = double "Retire"
    allow(PlayerRepository::UnwantedPlayers)
      .to receive(:without_contract_since)
      .with(Date.new(2013,7,1))
      .and_return []
    expect(PlayerUseCase::Retirement)
      .to receive(:new)
      .with(player: player, year: 2015)
      .and_return(double("Retirement", retire?: true))
    expect(retirements.decisions).to eq [1]
  end

    it "retires unwanted players" do
    expect(PlayerRepository::OldPlayers)
      .to receive(:active_and_born_in)
      .with(birthyear: 2015)
      .and_return []
    allow(PlayerRepository::UnwantedPlayers)
      .to receive(:without_contract_since)
      .with(Date.new(2013,7,1))
      .and_return [player]
    expect(PlayerUseCase::Retirement)
      .to receive(:new)
      .with(player: player, year: 2015)
      .and_return(double("Retirement", retire!: true))
    expect(retirements.decisions).to eq [1]
  end

end

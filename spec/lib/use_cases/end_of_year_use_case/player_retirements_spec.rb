# require_relative '../../../../lib/use_cases/end_of_year_use_case/player_retirements'
# require "active_support/core_ext/integer/time"
require 'spec_helper' # don't know where to find rails class for + years

RSpec.describe EndOfYearUseCase::PlayerRetirements do
  subject(:retirements) do
    EndOfYearUseCase::PlayerRetirements.new(year: 2000)
  end

  let(:date) { Date.new(2000,3,31) }
  let(:player) { double("Player", id: 1) }

  it "asks old players whether to retire" do
    expect(PlayerRepository::OldPlayers)
      .to receive(:find_at)
      .with(birthyear: 2000)
      .and_return [player]
    retire = double "Retire"
    expect(PlayerUseCase::Retirement)
      .to receive(:new)
      .with(player: player, year: 2000)
      .and_return(double("Retirement", retire?: true))
    expect(retirements.decisions).to eq [1]
  end

end

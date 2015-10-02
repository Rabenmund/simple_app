# require_relative "../../../../lib/use_cases/player_use_case/contract_end_date"
# require "active_support/core_ext/integer/time"
require 'spec_helper' # don't know where to find rails class for + years

RSpec.describe PlayerUseCase::ContractEndDate do
  subject(:end_date) do
    PlayerUseCase::ContractEndDate.call(start_date: date, player: player)
  end
  let(:date) { Date.new(2015,7,1) }
  let(:player) { double("Player", human: :human) }
  let(:age) { double("Age") }

  before do
    allow(HumanRepository::Age)
      .to receive(:new)
      .and_return age
  end

  it "provides a 3 year for normal players" do
    allow(age).to receive(:age_at).and_return 26
    allow(PlayerUseCase::ContractEndDate).to receive(:rand).and_return 2
    expect(end_date).to eq date + 3.years - 1.day
  end

  it "provides a 5 year for a very young player" do
    allow(age).to receive(:age_at).and_return 18
    allow(PlayerUseCase::ContractEndDate).to receive(:rand).and_return 2
    expect(end_date).to eq date + 5.years - 1.day
  end

  it "provides a 1 year for a very old player" do
    allow(age).to receive(:age_at).and_return 38
    allow(PlayerUseCase::ContractEndDate).to receive(:rand).and_return 0
    expect(end_date).to eq date + 1.year - 1.day
  end
end

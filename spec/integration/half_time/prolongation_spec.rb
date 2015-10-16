require 'spec_helper'

RSpec.describe SeasonUseCase::TeamProlongations do
  subject do
    SeasonUseCase::TeamProlongations
  end

  let(:team) { create :team }
  let(:date) { Date.new(2015,6,30) }

  it "prolongates a useful player" do
    strong = create :player, keeper: 500
    create :contract,
      human: strong.human,
      organization: team.organization,
      from: date - 1.year,
      to: date
    average = create :player, keeper: 300
    create :contract,
      human: average.human,
      organization: team.organization,
      from: date - 1.year,
      to: date + 1.year
    poor = create :player, keeper: 100
    create :contract,
      human: poor.human,
      organization: team.organization,
      from: date - 1.year,
      to: date

    expect(subject.decisions(date: date)).to eq [strong.id]
  end

end

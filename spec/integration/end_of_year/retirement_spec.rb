require 'spec_helper'

RSpec.describe EndOfYearUseCase::PlayerRetirements do
  subject do
    EndOfYearUseCase::PlayerRetirements.new(year: 2015)
  end

  let(:date) { Date.new(2015,7,1) }

  it "retires an old player" do
    human = create :human, birthday: Date.new(1999,3,31)
    young = create :player, human: human
    create :contract, human: human, from: date, to: date+1.year-1.day
    human2 = create :human, birthday: Date.new(1969,3,31)
    old = create :player, human: human2
    create :contract, human: human2, from: date, to: date+1.year-1.day

    expect(subject.decisions).to eq [old.id]
  end

end

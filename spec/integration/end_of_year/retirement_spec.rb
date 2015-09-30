require 'spec_helper'

RSpec.describe EndOfYearUseCase::PlayerRetirements do
  subject do
    EndOfYearUseCase::PlayerRetirements.new(year: 2015)
  end

  it "retires an old player" do
    human = create :human, birthday: Date.new(1999,3,31)
    young = create :player, human: human
    human2 = create :human, birthday: Date.new(1969,3,31)
    old = create :player, human: human2

    expect(subject.ask_for_decisions).to eq [old.id]
  end

end

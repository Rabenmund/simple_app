require 'spec_helper'

RSpec.describe SeasonUseCase::CompetitionStart do
  subject(:start) { described_class }

  it "has the correct start date" do
    expect(start.date_for(year: 2015))
      .to eq Date.new(2015,8,8)
  end
end

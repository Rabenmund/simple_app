require 'spec_helper'

RSpec.describe SeasonEventing::TearDown do
  subject(:event) { SeasonEventing::TearDown.new(season: season) }
  let(:season) { create :season }

  it "is valid" do
    expect(event).to be_valid
  end

  it "calls the tear up event for the next season" do
    expect(SeasonUseCase::TearUp)
      .to receive(:new)
      .and_return double("eventer", invoke: true)
    event.call
    expect(Season.count).to eq 2
    expect(season.next_one).to eq Season.last
  end
end

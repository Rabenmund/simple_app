require 'spec_helper'

RSpec.describe SeasonEventing::FinishPlayerExchangeCreator do
  let(:season) { create :season }

  it "creates a finish player exchange event and appoint it" do
    SeasonEventing::FinishPlayerExchangeCreator.for_season season
    event = SeasonEventing::FinishPlayerExchange.last
    expect(event).to be_valid
    expect(event.appointed_at).to eq season.end_date
  end
end

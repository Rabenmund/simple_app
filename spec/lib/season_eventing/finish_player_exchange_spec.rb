require 'spec_helper'

RSpec.describe SeasonEventing::FinishPlayerExchange do
  subject(:finisher) do
    SeasonEventing::FinishPlayerExchange.new(season: season)
  end
  let(:season) { create :season }

  it "calls the finish player exchange for the season"
end

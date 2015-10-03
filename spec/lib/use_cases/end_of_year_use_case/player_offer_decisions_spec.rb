require_relative '../../../../lib/use_cases/end_of_year_use_case/player_offer_decisions'

RSpec.describe EndOfYearUseCase::PlayerOfferDecision do
  subject(:decision) do
    EndOfYearUseCase::PlayerOfferDecision.decisions(date: date)
  end

  it "does anything"
end

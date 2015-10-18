require_relative '../../../lib/season_use_case/tear_up'

RSpec.describe SeasonUseCase::TearUp do
  subject(:tear_up) { SeasonUseCase::TearUp.new(id: 1) }

  it "invokes the season event plan"
  it "invokes the competition plans"

end

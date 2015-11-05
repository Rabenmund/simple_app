require_relative '../../../lib/season_use_case/competition_planner.rb'

RSpec.describe SeasonUseCase::CompetitionPlanner do
  subject(:planner) do
    SeasonUseCase::CompetitionPlanner.new(season: season)
  end

  let(:season) { create :season }

  it "does anything"
end


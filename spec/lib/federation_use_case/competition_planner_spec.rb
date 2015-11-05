require_relative '../../../lib/federation_use_case/competition_planner.rb'

RSpec.describe FederationUseCase::CompetitionPlanner do
  subject(:planner) do
    FederationUseCase::CompetitionPlanner.new(federation: federation)
  end

  let(:federation) { create :federation }

  it "does anything"
end

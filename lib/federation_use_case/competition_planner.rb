module FederationUseCase
  class CompetitionPlanner
    def initialize(federation:)
      @federation = federation
    end

    def for_season(season)
      federation.competition_plan.for_season(season)
    end

    private

    attr_reader :federation
  end
end

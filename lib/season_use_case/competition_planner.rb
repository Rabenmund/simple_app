module SeasonUseCase
  class CompetitionPlanner
    def initialize(season: season)
      @season = season
    end

    def by_federations(federations)
      federations.each do |federation|
        FederationUseCase::CompetitionPlanner
          .new(federation: federation)
          .for_season(season)
      end
    end

    private

    attr_reader :season
  end
end

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

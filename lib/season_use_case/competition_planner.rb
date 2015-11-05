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

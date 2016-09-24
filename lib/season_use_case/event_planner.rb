module SeasonUseCase
  class EventPlanner
    def initialize(season:)
      @season = season
    end

    def call
      SeasonEventing::FinishPlayerExchangeCreator.for_season(season)
      SeasonEventing::HalfTimeCreator.for_season(season)
      SeasonEventing::TearDownCreator.for_season(season)
    end

    private

    attr_reader :season
  end
end

module SeasonUseCase
  class EventPlanner
    def initialize(season: season)
      @season = season
    end

    def call
      # create finish player exchange event
      # create half time event
      SeasonEventing::HalfTimeCreator.for_season(season)
      # create tear down event
    end

    private

    attr_reader :season
  end
end

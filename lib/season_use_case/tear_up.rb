module SeasonUseCase
  class TearUp
    def initialize(season: season)
      @season = season
    end

    def invoke
      # no event / not appointed - will be called by tear down event

      # TODO calculate reputation missing

      EventPlanner.new(season: season).call
    end

    private

    attr_reader :season
  end
end

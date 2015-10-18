module SeasonUseCase
  class TearUp
    def initialize(season: season)
      @season = season
    end

    def invoke
      # no event / not appointed - will be called by tear down event

      # create season events
      EventPlanner.new(season: season).call
      # create competitions according federation plans
      # federations.each { |f| CompetitionPlanner(federation: f).new.call }
      # oder
      # DFBCompetitionPlanner.new(season: season).call
      # UEFACompetitionPlanner ...
    end

    private

    attr_reader :season
  end
end

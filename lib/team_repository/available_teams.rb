module TeamRepository
  class AvailableForLeague
    def initialize(league:)
      @league = league
    end

    def random(size)
      scheduled =
        season
        .teams
        .joins(:competitions)


      available = season.teams - scheduled
      # available.first(size)
    end

    private

    attr_reader :season
  end
end

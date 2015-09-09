module LeagueRepository
  class StartDate
    def initialize(id:)
      @league = League.find(id)
    end

    def start_date
      league.start
    end

    private

    attr_reader :league
  end
end

module LeagueRepository
  class Adapter
    def initialize(id:)
      @league = League.find(id)
    end

    def team_ids
      league.team_ids
    end

    def start_date
      league.start
    end

    private

    attr_reader :league
  end
end

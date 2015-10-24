module LeagueService
  class FillUpTeams

    def initialize(league:)
      @league = league
    end

    def fill_up
      TeamService::FillUp
        .new(teams: league.teams, start_date: league.start_date)
        .fill_up
    end

    private

    attr_reader :league
  end
end

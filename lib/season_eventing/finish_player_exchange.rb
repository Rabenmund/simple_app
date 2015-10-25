module SeasonEventing
  class FinishPlayerExchange < SeasonEvent
    def call
      fill_up_by_league
      fill_up_all_teams_without_league
    end

    private

    def fill_up_by_league
      season.leagues.each do |league|
        LeagueService::FillUpTeams
          .new(league: league)
          .fill_up
      end
    end

    def fill_up_all_teams_without_league
      TeamService::FillUp
        .new(teams: season.teams, start_date: season.start_date)
        .fill_up
    end
  end
end

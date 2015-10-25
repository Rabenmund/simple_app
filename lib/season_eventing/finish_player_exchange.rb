module SeasonEventing
  class FinishPlayerExchange < SeasonEvent
    def call
      fill_up_by_league # first
      fill_up_all_teams_without_league # the rest
    end

    private

    def fill_up_by_league
      season.leagues.order(level: :asc).each do |league|
        TeamService::FillUp
          .new(teams: league.teams, start_date: season.start_date)
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

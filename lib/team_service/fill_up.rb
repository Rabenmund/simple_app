module TeamService
  class FillUp
    def initialize(teams:, start_date:)
      @teams = teams
      @start_date = start_date
    end

    def fill_up
      exchange_players_for incompleted_teams(teams)
    end

    private

    attr_reader :teams, :start_date

    # Recursive
    def exchange_players_for(teams)
      return true if teams.empty?

      TeamService::PlayerExchangeRound.new(
        teams: teams,
        contract_start: start_date
      ).execute

      exchange_players_for incompleted_teams(teams)
    end

    def incompleted_teams(teams)
      TeamService::Incompleted
        .new(teams: teams, date: start_date)
        .need_players
    end
  end
end

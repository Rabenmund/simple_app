module TeamService
  class FillUp
    def initialize(ids:, start_date:)
      @ids = ids
      @start_date = start_date
    end

    def fill_up
      exchange_players_for incompleted_teams(ids)
      return ids
    end

    private

    attr_reader :ids, :start_date

    # Recursive
    def exchange_players_for(team_ids)
      return true if team_ids.empty?

      TeamService::PlayerExchangeRound.new(
        team_ids: team_ids,
        contract_start: start_date
      ).execute

      exchange_players_for incompleted_teams(team_ids)
    end

    def incompleted_teams(team_ids)
      TeamService::Incompleted
        .new(ids: team_ids, date: start_date)
        .teams
    end
  end
end

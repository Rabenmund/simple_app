require 'league_repository/start_date'
require 'league_repository/adapter'
require 'team_service/incompleted'
require 'team_service/player_exchange_round'

module LeagueService
  class FillUpTeams

    def initialize(id:)
      @id = id
      @start_date = LeagueRepository::StartDate.new(id: id).start_date
      @league_team_ids = LeagueRepository::Adapter.new(id: id).team_ids
    end

    def fill_up
      exchange_players_for incompleted_teams(league_team_ids)
    end

    private

    attr_reader :id, :start_date, :league_team_ids

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

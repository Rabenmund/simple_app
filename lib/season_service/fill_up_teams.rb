require 'season_repository/adapter'
require 'league_service/fill_up_teams'
require 'team_service/fill_up'

module SeasonService
  class FillUpTeams
    def initialize(id:)
      @id = id
      adapter = SeasonRepository::Adapter.new(id: id)
      @league_ids = adapter.league_ids
      @team_ids = adapter.team_ids
      @start_date = adapter.start_date
    end

    def fill_up
      league_ids.each do |league_id|
        LeagueService::FillUpTeams.new(id: league_id).fill_up
      end
      TeamService::FillUp.new(ids: team_ids, start_date: start_date).fill_up
    end

    private

    attr_reader :id, :league_ids, :team_ids, :start_date

  end
end

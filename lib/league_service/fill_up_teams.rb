require 'league_repository/adapter'

module LeagueService
  class FillUpTeams

    def initialize(id:)
      adapter = LeagueRepository::Adapter.new(id: id)
      @start_date = adapter.start_date
      @team_ids = adapter.team_ids
    end

    def fill_up
      TeamService::FillUp.new(ids: team_ids, start_date: start_date).fill_up
    end

    private

    attr_reader :start_date, :team_ids
  end
end

require 'team_service/keep_incomplete_teams'
module LeagueService
  class CompleteTeams

    def initialize(league)
      @league = league
      @start_date = league.start
    end

    def complete
      round(teams: incomplete_teams(teams: league.teams))
    end

    private

    attr_reader :league, :start_date

    def round(teams:)
      return if teams.empty?
      PlayerNegotiationRound.execute(teams: teams,
                                     contract_date: start_date)
      round(teams: incomplete_teams(teams: teams))
    end

    def incomplete_teams(teams:)
      TeamService::KeepIncompleteTeams.kept(teams)
    end
  end
end

module TeamService
  class Incompleted
    def initialize(teams:, date:)
      @teams = teams
      @date = date
    end

    def need_players
      teams.keep_if {|team| needs_player? team }
    end

    private

    attr_reader :teams, :date

    def needs_player?(team)
      needed_structure(team).size > 0
    end

    def needed_structure(team)
      TeamService::Needs.new(team: team, date: date).team_structure
    end
  end
end

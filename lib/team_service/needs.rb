module TeamService
  class Needs
    def initialize(team:, date:)
      @date = date
      @team = team
    end

    def team_structure
      goal_team_structure - current_team_structure
    end

    private

    attr_reader :team, :date

    def goal_team_structure
      TeamStructure.new(3,8,8,4)
    end

    def current_team_structure
      TeamRepository::CurrentTeamStructure
        .new(team: team)
        .team_structure_at(date)
    end

  end
end

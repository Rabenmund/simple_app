require 'team_repository/current_team_structure'
require 'team_structure'

module TeamService
  class Needs
    def initialize(id:, date:)
      @date = date
      @id = id
    end

    def team_structure
      goal_team_structure - current_team_structure
    end

    private

    attr_reader :id, :date

    def goal_team_structure
      TeamStructure.new(3,8,8,4)
    end

    def current_team_structure
      TeamRepository::CurrentTeamStructure
        .current_team_structure(id: id, date: date)
    end

  end
end

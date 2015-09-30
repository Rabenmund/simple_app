module TeamRepository
  class CurrentTeamStructure
    def initialize(team:)
      @team = team
    end

    def team_structure_at(date)
      team_structure = TeamStructure.new
      %w[keepers defenders midfielders attackers].each do |type|
        team_structure.type_count(type, type_count_at(date, type))
      end
      team_structure
    end

    private

    attr_reader :team

    def type_count_at(date, type)
      PlayerQuery
        .new(team: team)
        .type_count_at(date, type)
    end

  end
end

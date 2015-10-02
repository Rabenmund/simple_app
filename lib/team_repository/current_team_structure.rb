module TeamRepository
  class CurrentTeamStructure
    def initialize(team:)
      @team = team
    end

    def team_structure_at(date)
      team_structure = TeamStructure.new
      %w[keeper defense midfield attack].each do |type|
        team_structure
          .type_count(TYPE_PLAYERS[type.to_sym], type_count_at(date, type))
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

    TYPE_PLAYERS = {
      keeper: :keepers,
      defense: :defenders,
      midfield: :midfielders,
      attack: :attackers
    }

  end
end

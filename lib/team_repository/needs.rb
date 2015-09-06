module TeamRepository
  class Needs
    def initialize(id:, date:)
      @team = Team.find(id)
      @date = date
      @players_query = TeamQuery::Players.new(id: id)
    end

    def players
      needs = Hash.new
      %w[keepers defenders midfielders attackers].each do |type|
        needs[type.to_sym] = player_needs(type.to_sym)
      end
      needs
    end

    private

    attr_reader :team, :date, :players_query

    def player_needs(type)
      type_needed(type) - player_size(type)
    end

    def type_needed(type)
      (formation[type]*2).to_int
    end

    def player_size(type)
      players_query.size(type: type, date: date)
    end

    def formation
      @formation ||= TeamRepository::Formation.new(id: team.id).formation
    end
  end
end

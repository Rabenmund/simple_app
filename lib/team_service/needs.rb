module TeamService
  class Needs
    def initialize(id:, date:)
      @team_id = id
      @date = date
      @players_repo = TeamRepository::Players.new(id: id)
    end

    def players
      needs = Hash.new
      %w[keepers defenders midfielders attackers].each do |type|
        needs[type.to_sym] = player_needs(type.to_sym)
      end
      needs
    end

    private

    attr_reader :team_id, :date, :players_repo

    def player_needs(type)
      type_needed(type) - player_size(type)
    end

    def type_needed(type)
      (formation[type]*2).to_int
    end

    def player_size(type)
      players_repo.size(type: type, date: date)
    end

    def formation
      @formation ||= TeamRepository::Formation.new(id: team_id).formation
    end
  end
end

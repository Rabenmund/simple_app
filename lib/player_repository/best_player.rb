module PlayerRepository
  class NoBestPlayerFoundError < StandardError; end

  class BestPlayer

    STRENGTH = {
      keeper: :keeper,
      defender: :defense,
      midfielder: :midfield,
      attacker: :attack
    }

    def initialize(type:, date:, reputation:, team:)
      @strength = STRENGTH[type.to_sym]
      @date = date
      @reputation = reputation
      @team = team
      @best_player = player
      validate_player_existing
    end

    attr_reader :best_player

    private

    attr_reader :strength, :date, :reputation, :team

    def validate_player_existing
      best_player || raise(NoBestPlayerFoundError)
    end

    def player
      Player
        .active
        .without_offer_by(team.id, date)
        .without_contract_at(date)
        .without_too_many_hard_competitors(reputation)
        .where.not(strength => 0)
        .order(strength => :desc)
        .first
    end
  end
end

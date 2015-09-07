module PlayerRepository

  class BestPlayer

    STRENGTH = {
      keeper: :keeper,
      defender: :defense,
      midfielder: :midfield,
      attacker: :attack
    }

    def initialize(type:, date:, reputation:, team_id:)
      @strength = STRENGTH[type.to_sym]
      @date = date
      @reputation = reputation
      @team_id = team_id
    end

    def best_player
      Player
        .active
        .without_offer_by(team_id, date)
        .without_contract_at(date)
        .without_too_many_hard_competitors(reputation)
        .where.not(strength => 0)
        .order(strength => :desc)
        .first
    end

    private

    attr_reader :strength, :date, :reputation, :team_id
  end
end

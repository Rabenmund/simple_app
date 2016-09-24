module TeamRepository
  class PlayerQuery

    def initialize(team:)
      @team = team
    end

    def players_at(date)
      team
        .players
        .where("contracts.from <= ? AND contracts.to >= ?", date, date)
    end

    def type_at(date, type)
      team
        .players
        .where("players.#{type} > 0", type)
        .where("contracts.from <= ? AND contracts.to >= ?", date, date)
    end

    def type_count_at(date, type)
      type_at(date, type).count
    end

    def strength_at(date)
      team
        .players
        .where("contracts.from <= ? AND contracts.to >= ?", date, date)
        .sum("players.keeper"\
             " + players.defense"\
             " + players.midfield"\
             " + players.attack")
    end

    def type_strength_at(date, type)
      team
        .players
        .where("contracts.from <= ? AND contracts.to >= ?", date, date)
        .sum("players.#{type}", type)
    end

    def avg_at(date)
      strength_at(date) / players_at(date).count
    end

    def type_avg_at(date, type)
      type_strength_at(date, type) / type_at(date, type).count

    end

    private

    attr_reader :team

  end
end

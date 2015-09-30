module PlayerRepository
  class EndingContracts
    def initialize(date: date)
      @date = date
    end

    def for_team(team)
      team
        .players
        .joins(:contracts)
        .where("contracts.to = ?", date)
    end

    private

    attr_reader :date
  end
end

module TeamAdapter
  class PlayersWithEndingContract
    def initialize(id:)
      @team = Team.find(id)
    end

    def ending_at(date)
      team
        .players
        .joins(:contracts)
        .where("contracts.to = ?", date)
    end

    private

    attr_reader :team

  end
end

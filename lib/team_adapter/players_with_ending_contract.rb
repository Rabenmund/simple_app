module TeamAdapter
  class PlayersWithEndingContract
    def initialize(team:)
      @team = team
    end

    def contracts_ending_at(date)
      team
        .players
        .joins(:contracts)
        .where("contracts.to = ?", date)
        .uniq
    end


    private

    attr_reader :team

  end
end

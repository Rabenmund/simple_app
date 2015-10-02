module TeamRepository
  class EndingContracts
    def initialize(date: date)
      @date = date
    end

    def players
      Team
        .joins(:players)
        .joins(:contracts)
        .where("contracts.to = ?", date)
        .uniq
    end

    private

    attr_reader :date
  end
end

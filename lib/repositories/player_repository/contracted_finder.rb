module PlayerRepository
  module ContractedFinder
    class << self
      def at(date)
        Player
          .joins(:human)
          .joins(:contracts)
          .where("contracts.to >= ?", date)
      end
    end
  end
end


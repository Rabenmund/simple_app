module PlayerRepository
  module Active
    class << self
      def at(date)
        PlayerRepository::ContractableFinder.at(date) +
          ContractedFinder.at(date)
      end
    end
  end
end

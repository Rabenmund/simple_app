module PlayerRepository
  module ContractableFinder
    class << self
      def at(date)
        PlayerRepository::NotContractedFinder.at(date)
          .where(retired: false)
      end
    end
  end
end

module PlayerRepository
  module ContractableFinder
    class << self
      def at(date)
        ContractedFinder.at(date)
          .where(retired: false)
      end
    end
  end
end

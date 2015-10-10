module PlayerRepository
  module ActiveCounter
    class << self
      def at(date)
        ContractableFinder.at(date).count + ContractedFinder.at(date).count
      end
    end
  end
end

module PlayerRepository
  module NotContractedFinder
    class << self
      def at(date)
        Player
          .joins(:human)
          .joins('LEFT OUTER JOIN contracts '\
                 'ON contracts.human_id = humen.id')
          .where('(GREATEST(contracts.to) < ?) OR contracts.id IS NULL', date)
          .uniq
      end
    end
  end
end


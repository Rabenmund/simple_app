module PlayerRepository
  module OpenOffers
    class << self

      def all
        Player
          .joins(:offers)
          .where(offers: {accepted: false} )
          .uniq
      end

    end
  end
end

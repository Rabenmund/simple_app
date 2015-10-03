module PlayerRepository
  module OpenOffers
    class << self

      def all
        Player
          .joins(:offers)
          .where(offers: {accepted: false} )
      end

    end
  end
end

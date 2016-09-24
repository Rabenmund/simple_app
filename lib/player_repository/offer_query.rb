module PlayerRepository
  class OfferQuery

    def initialize(player:)
      @player = player
    end

    def id_and_reputations
      player
        .offers
        .open
        .pluck(:id, :reputation)
    end

    private

    attr_reader :player
  end
end

module PlayerRepository
  class CloseAllOffers
    def initialize(player: player)
      @player = player
    end

    def close
      player.offers.update_all(negotiated: true)
    end

    private

    attr_reader :player
  end
end

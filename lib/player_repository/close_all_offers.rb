module PlayerRepository
  class CloseAllOffers
    def initialize(id:)
      @player = Player.find(id)
    end

    def close
      player.offers.update_all(negotiated: true)
    end

    private

    attr_reader :player
  end
end

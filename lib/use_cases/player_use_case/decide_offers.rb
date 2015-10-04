module PlayerUseCase
  class DecideOffers
    def initialize(player:)
      @player = player
    end

    def accept_acceptable_offer
      accept_best_offer if acceptable?(best_offer)
      PlayerRepository::CloseAllOffers.new(player: player).close
    end

    def accept_best_offer
      OfferRepository::Accept.new(offer: best_offer).accept!
      ContractRepository::Create.new(
        player: player,
        team: best_offer.team,
        from: best_offer.start_date,
        to: best_offer.end_date
      ).create
    end

    private

    attr_reader :player

    def best_offer
      @best_offer ||= PlayerUseCase::FindBestOffer.new(player: player).find!
    end

    def acceptable?(offer)
      PlayerUseCase::OfferDecision.new(player: player).acceptable?(offer)
    end

  end
end

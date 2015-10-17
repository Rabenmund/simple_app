module PlayerUseCase
  module AllDecideOffers
    class << self
      def decisions
        PlayerRepository::OpenOffers.all.each do |player|
          PlayerUseCase::DecideOffers
            .new(player: player)
            .accept_acceptable_offer
        end
      end
    end
  end
end

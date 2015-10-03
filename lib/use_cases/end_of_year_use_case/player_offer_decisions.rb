module EndOfYearUseCase
  class PlayerOfferDecision
    def initialize(date:)
      @date = date
    end

    def decisions
      PlayerRepository::OpenOffers.all.each do |player|
        # should not accept when retirement planned
        PlayerUseCase::DecideOffer.new(player: player).decide!
      end
    end

    private

    attr_reader :date
  end
end

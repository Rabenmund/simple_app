module PlayerUseCase
  class OfferDecision
    def initialize(player:)
      @player = player
    end

    def acceptable?
      true
    end

    private

    attr_reader :player
  end
end

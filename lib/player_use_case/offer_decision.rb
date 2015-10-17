module PlayerUseCase
  class OfferDecision
    def initialize(player:)
      @player = player
    end

    def acceptable?(offer)
      # TODO: more sophisticated later
      return false if player.retired?
      rand(3) > 0
    end

    private

    attr_reader :player
  end
end

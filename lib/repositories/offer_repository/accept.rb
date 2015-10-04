module OfferRepository
  class Accept
    def initialize(offer:)
      @offer = offer
    end

    def accept!
      offer.update!(accepted: true)
    end

    private

    attr_reader :offer
  end
end

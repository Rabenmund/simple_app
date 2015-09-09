module OfferRepository
  class Accept
    def initialize(id:)
      @offer = Offer.find(id)
    end

    def accept!
      offer.update!(accepted: true)
    end

    private

    attr_reader :offer
  end
end

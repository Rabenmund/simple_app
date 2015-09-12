module OfferRepository
  class Adapter
    attr_reader :offer

    def initialize(id:)
      @id = id
      @offer = Offer.find(id)
    end
  end
end

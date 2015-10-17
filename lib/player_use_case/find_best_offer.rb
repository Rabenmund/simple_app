module PlayerUseCase
  class NoBestOfferToContractError < StandardError; end

  class FindBestOffer
    def initialize(player: player)
      @player = player
    end

    def find!
      Offer.find(lottery)
    end

    private

    attr_reader :player

    def offers
      @offers ||= PlayerRepository::OfferQuery
        .new(player: player)
        .id_and_reputations
    end

    def create_tickets_by_reputation
      all_tickets = Hash.new
      number = 0
      offers.each do |offer, reputation|
        all_tickets[number] = offer
        reputation.times do |n|
          number += 1
          all_tickets[number] = offer
        end
      end
      all_tickets
    end

    def lottery
      tickets = create_tickets_by_reputation
      tickets[rand(tickets.size)] || fail(NoBestOfferToContractError)
    end
  end
end

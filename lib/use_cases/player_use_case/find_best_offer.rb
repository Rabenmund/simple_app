require 'repositories/player_repository/offer_query'

module PlayerUseCase
  class NoBestOfferToContractError < StandardError; end

  class FindBestOffer
    def initialize(player: player)
      @player = player
      @offers = id_and_reputations
      @tickets = buy_tickets_per_reputation
    end

    def find!
      find || fail(NoBestOfferToContractError)
    end

    def find
      tickets[lottery]
    end

    private

    attr_reader :player, :tickets, :offers

    def id_and_reputations
      PlayerRepository::OfferQuery.new(player: player).id_and_reputations
    end

    def buy_tickets_per_reputation
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
      rand(tickets.size)
    end
  end
end

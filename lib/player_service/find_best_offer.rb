require 'player_repository/adapter'

module PlayerService
  class FindBestOffer
    def initialize(id:)
      @id = id
      @tickets = buy_tickets_per_reputation
    end

    def offer
      tickets[lottery]
    end

    private

    attr_reader :id, :tickets

    def offers
      PlayerRepository::Adapter.new(id: id).offer_reputations
    end

    def buy_tickets_per_reputation
      _tickets = Hash.new
      number = 0
      offers.each do |_offer, _reputation|
        _tickets[number] = _offer
        _reputation.times do |n|
          number += 1
          _tickets[number] = _offer
        end
      end
      _tickets
    end

    def lottery
      rand(tickets.size)
    end
  end
end

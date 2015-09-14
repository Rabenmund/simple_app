module PlayerRepository
  class Adapter
    attr_reader :player

    def initialize(id:)
      @player = Player.find(id)
    end

    def human
      player.human
    end

    def offer_reputations
      player
        .offers
        .open
        .pluck(:id, :reputation)
    end

    def retire!
      player
        .update!(retired: true)
    end
  end
end

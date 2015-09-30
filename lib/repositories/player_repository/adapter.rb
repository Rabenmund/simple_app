module PlayerRepository
  class Updater
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

    def type
      player.main_type
    end

    def strength
      player.main_strength
    end
  end
end

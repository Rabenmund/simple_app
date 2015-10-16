module PlayerRepository
  class Updater
    attr_reader :player

    def initialize(player: player)
      @player = player
    end

    def retire!
      player
        .update!(retired: true)
    end
  end
end

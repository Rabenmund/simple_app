module PlayerRepository
  class Updater
    attr_reader :player

    def initialize(id:)
      @player = Player.find(id)
    end

    def retire!
      player
        .update!(retired: true)
    end
  end
end

module GameCreator
  class << self
    def create(date:, attributes:)
      game = Game.create(attributes)
      event = SeasonEventing::GameEventCreator
        .create(season: game.season, eventable: game, appointed_at: date)
      game
    end
  end
end

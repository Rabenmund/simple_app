class GamePlayEvent
  def initialize(game)
    @game = game
  end

  attr_reader :game

  def message
    {
      data: game
    }.to_json
  end

  def routing_key
    "games.#{game.id}.play"
  end
end

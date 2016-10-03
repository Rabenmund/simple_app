module SeasonEventing
  class GameEvent < SeasonEvent

    def perform
      return false if game.finished?
      GamePublisher.publish(GamePlayEvent.new(game))
    end

    private

    # STEP_TIME = 6
    # GAME_END = 5400

    def game
      eventable
    end

    def perform!(&block)
      yield
      save
      return eventable
    end

    # def performable?
    #   return false if game.finished?
    #   game.start! unless game.started?
    #   true
    # end

    # def add_step_time
    #   game.second = game.second + STEP_TIME
    # end

    # def to_be_finished?
    #   game.second >= GAME_END
    # end

    # def finish!
    #   game.finish!
    # end

    # def steps(times)
    #   times.times do |time|
    #     finish! if to_be_finished?
    #     break if finished?
    #     add_step_time
    #   end
    # end

  end
end

# TODO: refactor publisher. better interface
class GamePublisher
  def self.publish(event)
    publisher = new(event)
    publisher.publish
  end

  def initialize(event)
    @event = event
  end

  attr_reader :event

  def publish
    BunnyConnection.publish(
      exchange: 'games',
      message: event.serialize,
      routing_key: event.routing_key
    )
  end
end

class GamePlayEvent
  def initialize(game)
    @game = game
  end

  attr_reader :game

  def serialize
    {
      data: game
    }.to_json
  end

  def routing_key
    "games.#{game.id}.play"
  end
end

require 'bunny'
class BunnyConnection
  class << self
    def publish(exchange:, message:, routing_key:)
      exchange = channel.topic(exchange, durable: true)
      exchange.publish(
        message,
        persistent: true,
        routing_key: routing_key
      )
    end

    private

    def channel
      @channel ||= connection.create_channel
    end

    def connection
      rabbitmq_url = ENV['RABBITMQ_URL'] || 'amqp://guest:guest@localhost:5672'
      Bunny.new(rabbitmq_url).start
    end
  end
end

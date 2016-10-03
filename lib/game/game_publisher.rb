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
      message: event.message,
      routing_key: event.routing_key
    )
  end
end

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

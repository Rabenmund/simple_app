require 'spec_helper'

describe BunnyConnection do
  let(:connection) { double('Connection', create_channel: channel) }
  let(:exchange) { double('Exchange') }
  let(:channel) { double('Channel') }

  it "publishes a message" do
    expect(Bunny)
      .to receive(:new)
      .with('amqp://guest:guest@localhost:5672')
      .and_return double('Startable', start: connection)
    expect(channel)
      .to receive(:topic)
      .with(:exchange, durable: true)
      .and_return exchange
    expect(exchange)
      .to receive(:publish)
      .with(:message, persistent: true, routing_key: :routing_key)
    BunnyConnection.publish(
      exchange: :exchange, message: :message, routing_key: :routing_key
    )
  end
end

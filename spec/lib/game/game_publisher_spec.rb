require 'spec_helper'

describe GamePublisher do
  let(:event) do
    double("GameEvent", message: :message, routing_key: :routing_key)
  end

  it "publishes an event" do
    expect(BunnyConnection)
      .to receive(:publish)
      .with(
        exchange: 'games',
        message: :message,
        routing_key: :routing_key
      )
    GamePublisher.publish(event)
  end
end

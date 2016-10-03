require 'spec_helper'

describe GamePlayEvent do
  let(:event) { GamePlayEvent.new(game) }
  let(:game) { double("Game", id: 42) }

  it "has a game" do
    expect(event.game).to eq game
  end

  it "has a message" do
    expect(event.message).to eq({ data: game }.to_json)
  end

  it "has a routing key" do
    expect(event.routing_key).to eq "games.42.play"
  end
end

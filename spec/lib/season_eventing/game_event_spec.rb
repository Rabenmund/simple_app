require 'spec_helper'

RSpec.describe SeasonEventing::GameEvent do
  subject(:event) do
    create :game_event
  end

  let(:scene) { double }

  it "is valid" do
    expect(event).to be_valid
  end

  it "performs 10 steps" do
    game = event.step
    expect(game.second).to eq 60
  end

  it "performs all steps" do
    TIMES = 10
    total = 0
    TIMES.times do
      event = create :game_event
      start = Time.now
      game = event.perform
      expect(game.second).to eq 5400
      _time = (-(start-Time.now))
      total = total + _time
      puts "time-2-end-game: #{_time.to_s}"
    end
    puts "average: "+(total / TIMES).to_s
  end

  # it "performs a game scene" do
  #   expect(GameScene).to receive(:new).and_return scene
  #   expect(scene).to receive(:perform).at_least(90).times
  #   event.perform
  # end
end

require 'spec_helper'

RSpec.describe SeasonEventing::GameEvent do
  subject(:event) do
    create :game_event
  end

  it "is valid" do
    expect(event).to be_valid
  end

  it "calls the game"
end

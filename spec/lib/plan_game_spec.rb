require 'spec_helper'

RSpec.describe PlanGame do
  subject(:game) { PlanGame.new(home_id: 1, guest_id: 2, start: :start) }

  it "has attributes" do
    expect(game.attributes).to eq({home_id: 1, guest_id: 2})
  end

  it "has a start date" do
    expect(game.start).to eq :start
  end
end

require 'spec_helper'

describe GameEventer do

  let(:game) { create :game }
  let(:event) { GameEventer.new(game) }

  before do
  end

  it "performs a game event with a goal" do
    allow(event).to receive(:defense).and_return 0
    allow(event).to receive(:success).and_return 0
    expect(event.perform!).to eq true
  end

  it "performs a game event with no goal" do
    allow(event).to receive(:attack).and_return 0
    expect(event.perform!).to eq false
  end
end

require 'spec_helper'

RSpec.describe PlayerRepository::Factory do
  subject(:factory) { PlayerRepository::Factory }

  let(:date) { Date.new(2015,7,1) }

  before do
    allow(Name)
      .to receive(:prename)
      .and_return("Franz")
    allow(Name)
      .to receive(:family)
      .and_return("Beckenbauer")
  end

  it "creates a young keeper" do
    player = subject.new(date: date, age: :young, type: :keeper).create
    expect(player).to be_a Player

  end

  it "creates a random player" do
    player = subject.new(date: date).create
    expect(player).to be_a Player

  end

  it "creates specific player" do
    player = subject.new(date: date, params: {
      name: "Franz Beckenbauer",
      birthday: Date.new(1969,3,31),
      defense: 300 }).create
    expect(player).to be_a Player
  end
end

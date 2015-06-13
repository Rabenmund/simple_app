require 'spec_helper'

describe GeneratePlayer do
  let(:generator) { GeneratePlayer.new }

  before do
    allow(LogicalDate).to receive(:date).and_return Date.today
  end

  it "creates a player with random role" do
    expect(generator.random.birthday).to be_in(Date.today-35.years..Date.today-17.years)
  end

  it "creates a keeper" do
    expect(generator.keeper).to be_keeper
  end

  it "creates a defender" do
    expect(generator.defender).to be_defender
  end

  it "creates a midfielder" do
    expect(generator.midfielder).to be_midfielder
  end

  it "creates a attacker" do
    expect(generator.attacker).to be_attacker
  end
end

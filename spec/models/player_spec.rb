require 'spec_helper'

describe Player do

  let(:player) { create :player }

  it "is valid" do
    expect(player).to be_valid
  end

  it "is a keeper" do
    keeper = create :player, keeper: 100
    expect(keeper).to be_keeper
  end

  it "is a defender" do
    defender = create :player, defense: 100, keeper: 50
    expect(defender).to be_defender
  end

  it "is a midfielder" do
    midfielder = create :player, midfield: 100, attack: 100
    expect(midfielder).to be_midfielder
  end

  it "is a attacker" do
    attacker = create :player, attack: 100, midfield: 106
    expect(attacker).to be_attacker
  end

  it "is not a midfielder" do
    defender = create :player, defense: 100, midfield: 90
    expect(defender).to_not be_midfielder
  end
end

require_relative '../../lib/team_structure.rb'
require 'active_support/core_ext/string/inflections'

RSpec.describe TeamStructure do
  subject(:team_structure) { TeamStructure.new(3,8,8,4) }

  it "is valid" do
    expect(team_structure.keepers).to eq 3
    expect(team_structure.defenders).to eq 8
    expect(team_structure.midfielders).to eq 8
    expect(team_structure.attackers).to eq 4
  end

  it "substracts another team structure" do
    other = TeamStructure.new(1,2,3,4)
    expect(team_structure-other).to eq TeamStructure.new(2,6,5,0)
  end

  it "returns an error if subtrahent is not a TeamStructure" do
    expect{team_structure-1}
      .to raise_error TeamStructure::CannotSubtractClassError
  end

  it "sets a type to a count" do
    team_structure.type_count(:attackers, 1)
    expect(team_structure).to eq TeamStructure.new(3,8,8,1)
  end

  it "has a size" do
    expect(team_structure.size).to eq 23
  end

  it "takes a type" do
    type = team_structure.take_type!
    expect(type).to eq :keeper
    expect(team_structure).to eq TeamStructure.new(2,8,8,4)
  end

  it "returns a nil if no type can be taken" do
    expect(TeamStructure.new(0,0,0,0).take_type!).to eq nil
  end
end

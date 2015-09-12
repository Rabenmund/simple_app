require 'spec_helper'

RSpec.describe ContractRepository::Create do
  let(:date) { Date.new(2010,7,1) }
  let(:team) { create :team }
  let(:player) { create :player }

  before do
    create :contract,
      human: player.human,
      organization: team.organization,
      from: Date.new(2009,7,1),
      to: Date.new(2011,6,30)
  end

  it "creates a contract with valid data" do
   contract  = ContractRepository::Create.new(
     team_id: team.id,
     player_id: player.id,
     from: Date.new(2011,7,1),
     to: Date.new(2012,6,30)
   ).create
    expect(contract).to be_valid
  end

  it "does not create a contract if another is already existing" do
   expect{ContractRepository::Create.new(
     team_id: team.id,
     player_id: player.id,
     from: Date.new(2010,7,1),
     to: Date.new(2012,6,30)
   ).create}
     .to raise_error ContractRepository::DoubleContractError
  end

  it "does not create a contract if to < from" do
   expect{ContractRepository::Create.new(
     team_id: team.id,
     player_id: player.id,
     from: Date.new(2012,7,1),
     to: Date.new(2011,6,30)
   ).create}
     .to raise_error ContractRepository::WrongDateError
  end
end

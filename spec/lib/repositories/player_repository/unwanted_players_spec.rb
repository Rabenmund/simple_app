require 'spec_helper'

RSpec.describe PlayerRepository::UnwantedPlayers do
  it 'finds unwanted players at date' do
    unwanted = create :player
    create :contract, human: unwanted.human,
      from: Date.new(2011,7,1), to: Date.new(2013,6,30)
    wanted = create :player
    create :contract, human: wanted.human,
      from: Date.new(2013,7,1), to: Date.new(2014,6,30)
    expect(
      PlayerRepository::UnwantedPlayers
        .without_contract_since(Date.new(2013,7,1))
    ).to eq [unwanted]
  end
end

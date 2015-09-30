require 'spec_helper'

describe TeamRepository::EndingContracts do

  it "finds all teams having players with ending contracts" do
    team = create :team
    player = create :player
    create :contract,
      human: player.human,
      organization: team.organization,
      from: Date.new(2014,7,1),
      to: Date.new(2015,6,30)

    team2 = create :team
    player2 = create :player
    create :contract,
      human: player2.human,
      organization: team2.organization,
      from: Date.new(2014,7,1),
      to: Date.new(2016,6,30)

    expect(
      TeamRepository::EndingContracts.new(date: Date.new(2015,6,30)).players
    ).to eq [team]

  end
end

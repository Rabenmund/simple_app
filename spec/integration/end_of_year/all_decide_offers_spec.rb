require 'spec_helper'

RSpec.describe PlayerUseCase::AllDecideOffers do
  subject(:all) { PlayerUseCase::AllDecideOffers }

  it "decides all open offers" do
    team1 = create :team
    team2 = create :team
    player1 = create :player
    player2 = create :player
    offer1 = create :offer, player: player1, team: team1
    offer2 = create :offer, player: player1, team: team2
    offer3 = create :offer, player: player2, team: team1
    all.decisions
    expect(Offer.open.count).to eq 0
  end

end

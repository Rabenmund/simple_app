require 'spec_helper'

describe PlayerExchangeBroker do
  let(:team) { create :team }
  let(:season) { create :season }
  let(:league) { create :league, season: season }
  let(:broker) {
    PlayerExchangeBroker.new(
      team: team,
      keepers: 0,
      midfielders: 0,
      defenders: 0,
      attackers: 0,
      start_date: Date.today
    )}

  before do
    @keeper = create :keeper
    @defender = create :defender
    @midfielder = create :midfielder
    @attacker = create :attacker
    previous = create :league
    allow(league).to receive(:previous).and_return previous
    league.teams << team
    allow(broker).to receive(:players).and_return Player.all
  end

  it "has no needs to create offers" do
    expect{broker.offers_for(Player.all)}.to change{Offer.count}.by 0
  end

  it "puts offers for players" do
    broker.keepers = 1
    broker.defenders = 1
    broker.midfielders = 1
    broker.attackers = 1
    expect{broker.offers_for(Player.all)}.to change{Offer.count}.by 4
  end

  it "puts an offer for a keeper" do
    broker.keepers = 1
    broker.offers_for(Player.all)
    expect(Offer.count).to eq 1
    expect(Offer.first.team).to eq team
    expect(Offer.first.player).to eq @keeper
  end

  it "does not have enough player to create an offer" do
    broker.keepers = 2
    expect{broker.offers_for(Player.all)}.to raise_error
  end

  it "finds the best player" do
    player = create :keeper, keeper: 300
    create :offer, player: player, reputation: 1010
    create :offer, player: player, reputation: 1020
    create :offer, player: player, reputation: 100
    player2 = create :keeper, keeper: 200
    player3 = create :keeper, keeper: 400
    create :offer, player: player3, reputation: 1010
    create :offer, player: player3, reputation: 1020
    create :offer, player: player3, reputation: 1030
    player4 = create :keeper, keeper: 500
    create :offer, player: player4, team: broker.team
    expect(broker.new_best_player([player, player2, player3, player4])).
      to eq player
  end
end

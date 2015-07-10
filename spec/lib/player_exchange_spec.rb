require 'spec_helper'

describe PlayerExchange do

  let!(:season) { create :season }
  let!(:league1) { create :league, season: season, level: 1 }
  let!(:league2) { create :league, season: season, level: 2 }
  let!(:exchange) { PlayerExchange.new(season) }

  before do
    t1 = create :team
    t2 = create :team
    league1.teams << t1
    league1.teams << t2
    t3 = create :team
    t4 = create :team
    league2.teams << t3
    league2.teams << t4
  end

  context "put offers" do
    let(:brokers) { exchange.team_brokers [1] }

    before do
      create :keeper
      create :defender
      create :midfielder
      create :attacker
      allow(PlayerNeed).to receive(:new).and_return double(need: 1)
    end

    it "puts offers" do
      expect{exchange.offers_by(brokers)}.to change{Offer.count}.by(8)
    end

  end

  it "performs a negotiation_round" do

  end

  it "asks teams for brokers of leagues leveled 1" do
    brokers = exchange.team_brokers [1]
    expect(brokers).to be_a Array
    expect(brokers.size).to eq 2
    expect(league1.teams).to include brokers.first.team
  end

  it "asks teams for brokers of leagues leveled 1 and 2" do
    brokers = exchange.team_brokers [1, 2]
    expect(brokers).to be_a Array
    expect(brokers.size).to eq 4
    expect(league2.teams).to include brokers.last.team
  end

end

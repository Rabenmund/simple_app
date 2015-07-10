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

  context "#contractable" do
    before do
      @organization = create :organization
      @season = create(:season,
                         year: 2010,
                         start_date: Date.today,
                         end_date: Date.today
                      )
    end

    it "is contractable without contract" do
      expect(Player.contractable(@season)).to include player
    end

    it "is contractable with an inactive contract" do
      contract = create(:contract,
                          organization: @organization,
                          human: player.human,
                          from: Date.today-2.days,
                          to: Date.today-1.day
                       )
      expect(Player.contractable(@season)).to include player
    end

    it "is not contractable due to an active contract" do
      contract = create(:contract,
                          organization: @organization,
                          human: player.human,
                          from: Date.today-2.days,
                          to: Date.today+1
                       )
      expect(Player.contractable(@season)).to_not include player
    end

    it "is not contractable due to being inactive" do
      player.profession.update_attributes(active: false)
      expect(Player.contractable(@season)).to_not include player
    end
  end

  context ".without_offer_by" do
    let(:team) { create :team }

    it "scopes without offers" do
      expect(Player.without_offer_by team).to include player
    end

    it "does not scope with an offer" do
      Offer.create(team: team, player: player, reputation: 100)
      expect(Player.without_offer_by team).to_not include player
    end
  end

  # context ".without_better_offers" do

  #   it "scopes without any  offers" do
  #     expect(Player.without_better_offers(1, 100)).to include player
  #   end

  #   it "scopes without any better offers" do
  #     create :offer, player: player, reputation: 99
  #     expect(Player.without_better_offers(1, 100)).to include player
  #   end

  #   it "scopes without enough better offers" do
  #     create :offer, player: player, reputation: 101
  #     expect(Player.without_better_offers(2, 100)).to include player
  #   end

  #   it "does not scope with enough better offers" do
  #     create :offer, player: player, reputation: 101
  #     create :offer, player: player, reputation: 102
  #     expect(Player.without_better_offers(2,100)).to_not include player
  #   end
  # end

  it "has better offers" do
    create :offer, player: player, reputation: 101
    create :offer, player: player, reputation: 102
    create :offer, player: player, reputation: 100
    expect(player.better_offers 100).to eq 2
  end

end

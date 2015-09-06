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

  context ".active" do
    it "is active" do
      expect(Player.active).to include player
    end

    it "is not active" do
      player.profession.update!(active: false)
      expect(Player.active).to_not include player
    end
  end

  context ".without_offer_by" do
    it "scopes without offers" do
      expect(Player.without_offer_by 1).to include player
    end

    it "does not scope with an offer by team" do
      create :offer, team_id: 1, player: player, reputation: 100
      expect(Player.without_offer_by 1).to_not include player
    end

    it "scopes with offers from another team" do
      create :offer, team_id: 2, player: player, reputation: 1
      expect(Player.without_offer_by 1).to include player
    end
  end

  context ".without_contract_at(date)" do
    let(:date) { Date.new(2015,7,1) }

    it "scopes without any contract" do
      expect(Player.without_contract_at date).to include player
    end

    it "scopes with an elder contract only" do
      create :contract, human: player.human,
        from: Date.new(2014,7,1), to: Date.new(2015,6,30)
      expect(Player.without_contract_at date).to include player
    end

    it "does not scope with an matching contract" do
      create :contract, human: player.human,
        from: Date.new(2014,7,1), to: Date.new(2016,6,30)
      expect(Player.without_contract_at date).to_not include player
    end
  end

  context(".without_too_many_hard_competitors") do
    it "scopes without any other offers" do
      expect(Player.without_too_many_hard_competitors(100))
        .to include player
    end

    it "scopes with only 2 better offers existing" do
      create :offer, player: player, reputation: 100
      create :offer, player: player, reputation: 101
      create :offer, player: player, reputation: 101

      expect(Player.without_too_many_hard_competitors(100))
        .to include player
    end

    it "does not scope with 3 better offers existing" do
      create :offer, player: player, reputation: 101
      create :offer, player: player, reputation: 101
      create :offer, player: player, reputation: 101
      expect(Player.without_too_many_hard_competitors(100))
        .to_not include player
    end
  end

  it "is negotiable" do
    create :offer, player: player
    expect(Player.negotiable).to include player
  end

  it "is not negotiable" do
    expect(Player.negotiable).to_not include player
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

  it "has better offers" do
    create :offer, player: player, reputation: 101
    create :offer, player: player, reputation: 102
    create :offer, player: player, reputation: 100
    expect(player.better_offers 100).to eq 2
  end

end

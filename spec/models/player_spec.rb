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
    let(:date) { Date.new(2015,7,1) }

    it "scopes without offers" do
      expect(Player.without_offer_by 1, date).to include player
    end

    it "scopes with offers from another team" do
      create :offer, team_id: 2, player: player, reputation: 1
      expect(Player.without_offer_by 1, date).to include player
    end

    it "scopes with older offers from team" do
      create :offer, team_id: 1, player: player
      expect(Player.without_offer_by 1, date).to include player
    end

    it "does not scope with an offer by team" do
      create :offer, team_id: 1, player: player, start_date: date
      expect(Player.without_offer_by 1, date).to_not include player
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

end

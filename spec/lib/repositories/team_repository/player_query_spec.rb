require 'spec_helper'

describe TeamRepository::PlayerQuery do

  subject(:query) { TeamRepository::PlayerQuery.new(team: team) }
  let(:team) { create :team }
  let(:date) { Date.new(2015,7,1) }
  let(:player) { create :keeper, keeper: 42 }

  before do
    create :contract, human: player.human, organization: team.organization,
      from: date, to: date+1.year
  end

  it "has players at a date" do
    expect(query.players_at(date)).to include player
  end

  it "has a type at a date" do
    expect(query.type_at(date, :keepers)).to include player
  end

  it "has a type count at a date" do
    expect(query.type_count_at(date, :keepers)).to eq 1
  end

  it "does not have former players" do
    player2 = create :player
    create :contract, human: player2.human, organization: team.organization,
      from: date-1.year, to: date-1.day
    expect(query.players_at(date)).to_not include player2
  end

  it "has a strength at a date" do
    expect(query.strength_at(date)).to eq 42
  end

  it "has a type strength at a date" do
    expect(query.type_strength_at(date, :keepers)).to eq 42
  end

  it "has a strength average at a date" do
    expect(query.avg_at(date)).to eq 42
  end

  it "has a type strength average at a date" do
    expect(query.type_avg_at(date, :keepers)).to eq 42
  end

end


require 'spec_helper'

RSpec.describe TeamAdder do
  subject(:adder) { TeamAdder.new(teamable: cup) }
  let(:third_1) { create :league, season: season, level: 3}
  let(:third_2) { create :league, season: season, level: 3}
  let(:season) { create :season }
  let(:cup) { create :cup }
  let(:federation) { create :federation }

  before do
    3.times {|n| create_team n + 1, n + 1, third_1 }
    4.times {|n| create_team n + 4, n + 1, third_2 }
  end

  it "adds teams from leagues by ranking" do
    teamable = adder.from_leagues(season, 3, 2)
    expect(teamable.teams).to contain_exactly(@team1, @team2, @team4, @team5)
  end

  it "randomly adds missing teams" do
    adder.from_leagues(season, 3, 2)
    adder.randomly([@team3, @team6, @team7],3)
    expect(cup.teams.size).to eq 7
    expect(cup.teams).to contain_exactly(
      @team1, @team2, @team3, @team4, @team5, @team6, @team7
    )
  end

  it "fails without enough teams to randomly add" do
    plan = MethodicalHash.new({
          level: 1,
          qualified: MethodicalHash.new(
            leagues: {1 => 18, 2 => 18 }),
          name: "DFB Pokal",
          teams_no: 41
        })
    expect{adder.randomly([1], 2)}
      .to raise_error NotEnoughTeamsError
  end


end

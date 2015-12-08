require 'spec_helper'

RSpec.describe CupRepository::CupCreator do
  subject(:creator) do
    CupRepository::CupCreator
      .new(season: season, previous: previous_season, federation: federation)
  end

  let(:season) do
    create :season,
      year: 2016,
      start_date: Date.new(2015, 7, 1),
      end_date: Date.new(2016, 6, 30)
  end
  let(:previous_season) do
    create :season,
      year: 2015,
      start_date: Date.new(2014, 7, 1),
      end_date: Date.new(2015, 6, 30)
  end
  let(:previous_first) do
    create :league,
      season: previous_season,
      name: "Bundesliga",
      level: 1,
      federation: federation
  end
  let(:previous_second) do
    create :league,
      season: previous_season,
      name: "2.Bundesliga",
      level: 2,
      federation: federation
  end
  let(:federation) { create :federation }
  let(:plan) do
    double("Plan", cups: [
      MethodicalHash.new({
        level: 1,
        qualified: MethodicalHash.new(
          leagues: {1 => 18, 2 => 18 }),
        name: "DFB Pokal",
        teams_no: 64
      }),
    ])
  end

  before do
    18.times {|n| create_team n + 1, n + 1, previous_first }
    18.times {|n| create_team (n + 1 + 18), n + 1, previous_second }
    28.times {|n| create_team (n + 1 + 36) }
  end

  it "creates a cup" do
    cup = creator.by_plan(plan.cups.first)
    expect(cup.name).to eq "DFB Pokal"
    expect(cup.season).to eq season
    expect(cup.federation).to eq federation
    expect(cup.start).to eq Date.new(2015, 8, 8)
    expect(cup.teams.size).to eq 64
    expect(cup.matchdays.size).to eq 6
    expect(cup.matchdays.first.name).to eq "1.Runde"
    expect(cup.matchdays.last.name).to eq "Finale"
    expect(cup.matchdays.last.start).to eq Date.new(2016, 5, 28)
    expect(cup.draws.size).to eq 6
    expect(cup.draws.first.name).to eq "Auslosung 1.Runde"
  end
end


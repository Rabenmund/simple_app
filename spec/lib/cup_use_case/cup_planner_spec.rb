require 'spec_helper'

RSpec.describe CupUseCase::CupPlanner do
  subject(:planner) { described_class.new(season: season, previous: previous_season, federation: federation) }
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
            leagues: {1 => 18, 2 => 2, 3 => 18, 4 => 10}),
          name: "DFB Pokal",
          teams_no: 18
        })
    ])
  end

  before do
    previous_season.federations << federation
    18.times {|n| create_team n + 1, n + 1, previous_first }
    3.times {|n| create_team (n + 1 + 18), n + 1, previous_second }
    league = create(:league,
                    level: 1,
                    season: previous_season,
                    federation: federation
                   )
  end

  it "creates cups by plan" do
    planner.with_plan(plan.cups)
    expect(Cup.count).to eq 1
    expect(Cup.last.teams.size).to eq 20
  end
end

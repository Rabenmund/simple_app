require 'spec_helper'

RSpec.describe CupRepository::CupCreator do
  subject(:creator) do
    CupRepository::CupCreator
      .new(season: season, previous: previous, federation: federation)
  end

  let(:season) { double "Season", start_date: :start }
  let(:previous) { double "Previous" }
  let(:federation) { double "Federation", teams: [:team1, :team2, :team3]}
  let(:cup) { double "Cup", teams: [:team1, :team2] }
  let(:adder) { double "Adder", from_leagues: cup }
  let(:plan) do
    double("Plan", cups: [
      MethodicalHash.new({
        level: 1,
        qualified: MethodicalHash.new(
          leagues: {1 => 18, 2 => 18 }),
        name: "DFB Pokal",
        teams_no: 40
      }),
    ])
  end

  before do
    allow(Cup)
      .to receive(:create)
      .and_return(cup)
    allow(TeamAdder)
      .to receive(:new)
      .and_return(adder)
    allow(adder)
      .to receive(:randomly)
      .and_return(cup)
  end

  it "creates two cups" do
    expect(Cup)
      .to receive(:create)
      .with(level: 1,
    name: "DFB Pokal",
    season: season,
    federation: federation,
    start: :start
           )
      creator.by_plan(plan.cups.first)
  end

  it "adds teams to cups" do
    expect(TeamAdder)
      .to receive(:new)
      .with(teamable: cup)
      .and_return(adder)
    expect(adder)
      .to receive(:from_leagues)
      .with(previous, 1, 18)
      .and_return(adder)
    expect(adder)
      .to receive(:from_leagues)
      .with(previous, 2, 18)
      .and_return cup
    creator.by_plan(plan.cups.first)
  end

  it "randomly adds missing teams" do
    expect(adder)
      .to receive(:randomly)
      .with([:team3], 38)
    creator.by_plan(plan.cups.first)
  end

end


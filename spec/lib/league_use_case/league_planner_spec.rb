require 'spec_helper'

RSpec.describe LeagueUseCase::LeaguePlanner do
  subject(:creator) do
    LeagueUseCase::LeaguePlanner
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
  let(:first) { create :league, season: season }
  let(:plan) do
    double("Plan", leagues: [
      MethodicalHash.new({ name: "Bundesliga",
        level: 1,
        promoters_no: 3,
        relegators_no: 0,
        teams_no: 4 }),
      MethodicalHash.new({ name: "2.Bundesliga",
        level: 2,
        promoters_no: 3,
        relegators_no: 3,
        teams_no: 6 }),
      MethodicalHash.new({ name: "3.Bundesliga",
        level: 3,
        promoters_no: 3,
        relegators_no: 0,
        teams_no: 6 })
    ])
  end

  def create_team(n)
    eval "@team#{n} = create :team, federation: federation"
  end

  before do
    previous_season.federations << federation
    16.times {|n| create_team n }
    previous_first.teams << @team1 << @team2 << @team3 << @team4
    previous_second.teams <<
      @team5 << @team6 << @team7 << @team8 << @team9 << @team10

    allow(LeagueUseCase::Remainers)
      .to receive(:new)
      .with(league: previous_first)
      .and_return(double("RemainersInFirst", between: [@team1]))
    allow(LeagueUseCase::Remainers)
      .to receive(:new)
      .with(league: previous_second)
      .and_return(double("RemainersInSecond", between: []))
    allow(LeagueUseCase::Promoters)
      .to receive(:new)
      .with(league: previous_first)
      .and_return(double("PromotersToFirst", first: [@team5, @team6, @team7]))
    allow(LeagueUseCase::Promoters)
      .to receive(:new)
      .with(league: previous_second)
      .and_return(double("PromotersToSecond", first: [@team11, @team12, @team13]))
    allow(LeagueUseCase::Relegators)
      .to receive(:new)
      .with(league: previous_first)
      .and_return(double("RelegatorsToFirst", last: []))
    allow(LeagueUseCase::Relegators)
      .to receive(:new)
      .with(league: previous_second)
      .and_return(double("RelegatorsToSecond", last: [@team2, @team3, @team4]))
  end

  it "creates a first league with promoters" do
    creator.by_plan(plan.leagues)
    expect(season.leagues.reload.count).to eq 3
    first = season.leagues.find_by(name: "Bundesliga")
    expect(first.level).to eq 1
    teams = first.teams
    expect(teams.size).to eq 4
    expect(teams).to include @team1
    expect(teams).to include @team5
    expect(teams).to include @team6
    expect(teams).to include @team7
  end

  it "creates a second league with relegators and promoters" do
    creator.by_plan(plan.leagues)
    second = season.leagues.find_by(name: "2.Bundesliga")
    expect(second.level).to eq 2
    teams = second.teams
    expect(teams.size).to eq 6
    expect(teams).to include @team2
    expect(teams).to include @team3
    expect(teams).to include @team4
    expect(teams).to include @team11
    expect(teams).to include @team12
    expect(teams).to include @team13
  end

  it "creates a league without promoters" do
    creator.by_plan(plan.leagues)
    third = season.leagues.find_by(name: "3.Bundesliga")
    expect(third.level).to eq 3
    teams = third.teams
    expect(teams.size).to eq 6
    expect(teams).to include @team8
    expect(teams).to include @team9
    expect(teams).to include @team10
    expect(teams).to include @team14
    expect(teams).to include @team15
    expect(teams).to include @team0
  end

  it "should be refactored"

end

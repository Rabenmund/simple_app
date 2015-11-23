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
  let(:previous_third) do
    create :league,
      season: previous_season,
      name: "3.Bundesliga",
      level: 3,
      federation: federation
  end
  let(:federation) { create :federation }
  let(:first) { create :league, season: season }
  let(:plan) do
    double("Plan", leagues: [
      MethodicalHash.new({ name: "Bundesliga",
        level: 1,
        promoted_from_sub: 3,
        teams_no: 18 }),
      MethodicalHash.new({ name: "2.Bundesliga",
        level: 2,
        promoted_from_sub: 3,
        teams_no: 18 }),
      MethodicalHash.new({ name: "3.Bundesliga",
        level: 3,
        promoted_from_sub: 3,
        teams_no: 18 })
    ])
  end

  def create_team(n, m=n, league=nil)
    eval "@team#{n} = create :team, federation: federation"
    if league
      eval "league.teams << @team#{n}"
      eval "create :result, team: @team#{n}, league: league, rank: #{m}"
    end
  end

  before do
    previous_season.federations << federation
    18.times {|n| create_team n + 1, n + 1, previous_first }
    18.times {|n| create_team (n + 1 + 18), n + 1, previous_second }
    18.times {|n| create_team (n + 1 + 36), n + 1, previous_third }
    3.times {|n| create_team (n + 1 + 54) }
  end

  it "creates a first league with promoters" do
    creator.with_plan(plan.leagues)
    expect(season.leagues.reload.count).to eq 3
    first = season.leagues.find_by(name: "Bundesliga")
    expect(first.level).to eq 1
    teams = first.teams
    expect(teams.size).to eq 18
    expect(teams).to contain_exactly(
      @team1, @team2, @team3, @team4, @team5, @team6,
      @team7, @team8, @team9, @team10, @team11, @team12,
      @team13, @team14, @team15, @team19, @team20, @team21
    )

    second = season.leagues.find_by(name: "2.Bundesliga")
    expect(second.level).to eq 2
    teams = second.teams
    expect(teams.size).to eq 18
    expect(teams).to contain_exactly(
      @team16, @team17, @team18, @team22, @team23, @team24,
      @team25, @team26, @team27, @team28, @team29, @team30,
      @team31, @team32, @team33, @team37, @team38, @team39
    )

    third = season.leagues.find_by(name: "3.Bundesliga")
    expect(third.level).to eq 3
    teams = third.teams
    expect(teams.size).to eq 18
    expect(teams).to contain_exactly(
      @team34, @team35, @team36, @team40, @team41, @team42,
      @team43, @team44, @team45, @team46, @team47, @team48,
      @team49, @team50, @team51, @team55, @team56, @team57
    )

    expect(first.games.count).to eq 306
  end
end

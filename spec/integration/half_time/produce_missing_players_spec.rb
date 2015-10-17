require 'spec_helper'

RSpec.describe PlayerUseCase::MissingPlayerDetector do
  let(:date) { Date.new(2016,7,1) }
  it 'produces missing players' do
    GermanPreName.create(name: "Franz")
    GermanFamilyName.create(name: "Beckenbauer", weight: 100)
    season = create :season,
      start_date: date-1.year, end_date: date-1.day
    league = create :league, season: season
    team = create :team
    team2 = create :team
    league.teams << team
    league.teams << team2
    10.times do |n|
      player = create :player
      create :contract, {
        human: player.human,
        organization: team.organization,
        from: season.start_date,
        to: Date.new(2016,(1+n),1)
      }
    end
    10.times do |n|
      player = create :player
      create :contract, {
        human: player.human,
        organization: team2.organization,
        from: season.start_date,
        to: Date.new(2016,(1+n),1)
      }
    end

    Player.first.update!(retired: true) # not contracted at date
    Player.last.update!(retired: true) # contracted at date

    season2 = create :season,
      start_date: date, end_date: date+1.year-1.day
    league2 = create :league, season: season2
    league2.teams << team

    expect(Player.all.count).to eq 20
    expect(PlayerRepository::Active
      .for_teams_at(teams: Team.all, date: date).count).to eq 19
    expect(Team.all.count).to eq 2
    expect(TeamRepository::Active.at(date-1.day).count).to eq 2
    expect(TeamRepository::Active.at(date).count).to eq 1

    PlayerUseCase::MissingPlayerDetector.new(date: date).generate_players

    expect(PlayerRepository::ContractedFinder
             .for_team_at(team: team, date: date).count)
      .to eq 4
    teams = TeamRepository::Active.at(date)
    expect(PlayerRepository::ContractedFinder
             .for_teams_at(teams: teams, date: date).count)
      .to eq 4
    expect(PlayerRepository::ContractableFinder.at(date).count).to eq 21
  end
end

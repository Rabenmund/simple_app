require_relative '../../../lib/league_service/fill_up_teams.rb'

describe LeagueService::FillUpTeams do
  subject(:fill_up) { LeagueService::FillUpTeams.new(id: 1) }
  let(:date) { Date.new(2015,7,1) }

  it "fills up incompleted teams" do
    allow(LeagueRepository::StartDate)
      .to receive(:new)
      .with(id: 1)
      .and_return double("Date", start_date: date)
    allow(LeagueRepository::Adapter)
      .to receive(:new)
      .with(id: 1)
      .and_return double("TeamIds", team_ids: [1,2,3])
    allow(TeamService::Incompleted)
      .to receive(:new)
      .with(ids: [1,2,3], date: date)
      .and_return double("Teams", teams: [1,2])
    expect(TeamService::PlayerExchangeRound)
      .to receive(:new)
      .with(team_ids: [1,2], start_date: date)
      .and_return double("Round", execute: true)
    allow(TeamService::Incompleted)
      .to receive(:new)
      .with(ids: [1,2], date: date)
      .and_return double("Teams", teams: [1])
    expect(TeamService::PlayerExchangeRound)
      .to receive(:new)
      .with(team_ids: [1], start_date: date)
      .and_return double("Round", execute: true)
    allow(TeamService::Incompleted)
      .to receive(:new)
      .with(ids: [1], date: date)
      .and_return double("Teams", teams: [])
    expect(fill_up.fill_up).to eq true
  end
end

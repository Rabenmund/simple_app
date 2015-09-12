require_relative '../../../lib/league_service/fill_up_teams.rb'

describe LeagueService::FillUpTeams do
  subject(:fill_up) { LeagueService::FillUpTeams.new(id: 1) }
  let(:date) { Date.new(2015,7,1) }

  it "fills up incompleted teams" do
    allow(LeagueRepository::Adapter)
      .to receive(:new)
      .with(id: 1)
      .and_return double("TeamIds", team_ids: [1,2,3], start_date: date)
    expect(TeamService::FillUp)
      .to receive(:new)
      .with(ids: [1,2,3], start_date: date)
      .and_return double("Teams", fill_up: true)
    fill_up.fill_up
  end
end

require_relative '../../../lib/league_service/fill_up_teams.rb'

describe LeagueService::FillUpTeams do
  subject(:fill_up) { LeagueService::FillUpTeams.new(league: league) }
  let(:league) { double "League", teams: [1,2,3], start_date: :date }

  it "fills up incompleted teams" do
    expect(TeamService::FillUp)
      .to receive(:new)
      .with(teams: [1,2,3], start_date: :date)
      .and_return double("Teams", fill_up: true)
    fill_up.fill_up
  end
end

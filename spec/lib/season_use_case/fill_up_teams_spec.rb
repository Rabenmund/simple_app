require_relative '../../../lib/season_use_case/fill_up_teams'

RSpec.describe SeasonService::FillUpTeams do
  subject(:fill_up) { SeasonService::FillUpTeams.new(id: 1) }

  it "fills up all teams belonging to a league" do
    allow(SeasonRepository::Adapter)
      .to receive(:new)
      .with(id: 1)
      .and_return(
        double("Adapter",
               league_ids: [1,2],
               team_ids: [11,12,21,22],
               start_date: :date))
    expect(LeagueService::FillUpTeams)
      .to receive(:new)
      .with(id: 1)
      .and_return double("FillUp1", fill_up: [11,12])
    expect(LeagueService::FillUpTeams)
      .to receive(:new)
      .with(id: 2)
      .and_return double("FillUp2", fill_up: [21,22])
    expect(TeamService::FillUp)
      .to receive(:new)
      .and_return double("FillIncompleted", fill_up: true)
    fill_up.fill_up
  end

  it "fills up all teams belonging to a cup, but not a league" do
    allow(SeasonRepository::Adapter)
      .to receive(:new)
      .with(id: 1)
      .and_return(
        double("Adapter",
               league_ids: [1],
               team_ids: [91,92],
               start_date: :date))
    allow(LeagueService::FillUpTeams)
      .to receive(:new)
      .with(id: 1)
      .and_return double("FillUp1", fill_up: [])
    expect(TeamService::FillUp)
      .to receive(:new)
      .with(ids: [91, 92], start_date: :date)
      .and_return double("FillIncompleted", fill_up: true)
    fill_up.fill_up
  end
end

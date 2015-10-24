require_relative '../../../lib/team_service/fill_up.rb'

describe TeamService::FillUp do
  subject(:filler) do
    TeamService::FillUp.new(teams: [1,2,3], start_date: :date)
  end

  it "fills up incompleted teams" do
    allow(TeamService::Incompleted)
      .to receive(:new)
      .with(teams: [1,2,3], date: :date)
      .and_return double("Teams", need_players: [1,2])
    expect(TeamService::PlayerExchangeRound)
      .to receive(:new)
      .with(teams: [1,2], contract_start: :date)
      .and_return double("Round", execute: true)
    allow(TeamService::Incompleted)
      .to receive(:new)
      .with(teams: [1,2], date: :date)
      .and_return double("Teams", need_players: [1])
    expect(TeamService::PlayerExchangeRound)
      .to receive(:new)
      .with(teams: [1], contract_start: :date)
      .and_return double("Round", execute: true)
    allow(TeamService::Incompleted)
      .to receive(:new)
      .with(teams: [1], date: :date)
      .and_return double("Teams", need_players: [])
    filler.fill_up
  end
end

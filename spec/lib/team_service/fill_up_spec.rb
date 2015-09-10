require_relative '../../../lib/team_service/fill_up.rb'

describe TeamService::FillUp do
  subject(:fill_up) { TeamService::FillUp.new(ids: [1,2,3], start_date: date) }
  let(:date) { Date.new(2015,7,1) }

  it "fills up incompleted teams" do
    allow(TeamService::Incompleted)
      .to receive(:new)
      .with(ids: [1,2,3], date: date)
      .and_return double("Teams", teams: [1,2])
    expect(TeamService::PlayerExchangeRound)
      .to receive(:new)
      .with(team_ids: [1,2], contract_start: date)
      .and_return double("Round", execute: true)
    allow(TeamService::Incompleted)
      .to receive(:new)
      .with(ids: [1,2], date: date)
      .and_return double("Teams", teams: [1])
    expect(TeamService::PlayerExchangeRound)
      .to receive(:new)
      .with(team_ids: [1], contract_start: date)
      .and_return double("Round", execute: true)
    allow(TeamService::Incompleted)
      .to receive(:new)
      .with(ids: [1], date: date)
      .and_return double("Teams", teams: [])
    fill_up.fill_up
  end
end


require_relative '../../../lib/team_service/incompleted'

describe TeamService::Incompleted do

  subject(:incompleted) do
    TeamService::Incompleted.new(ids: [1,2], date: date)
  end
  let(:date) { Date.new(2015,7,1) }

  it "keeps all incomplete teams" do
    allow(TeamService::Needs)
      .to receive(:new)
      .with(id: 1, date: date)
      .and_return double(players?: false)
    allow(TeamService::Needs)
      .to receive(:new)
      .with(id: 2, date: date)
      .and_return double(players?: true)
    expect(incompleted.teams).to eq [2]
  end
end

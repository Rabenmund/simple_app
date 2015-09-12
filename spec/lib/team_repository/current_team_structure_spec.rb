require 'spec_helper'

RSpec.describe TeamRepository::CurrentTeamStructure do
  subject(:current_team_structure) do
    TeamRepository::CurrentTeamStructure
      .current_team_structure(id: team.id, date: date)
  end

  let(:team) { create :team }
  let(:date) { Date.new(2015,7,1) }

  it "provides the current team structure" do
    keeper = create :keeper
    create :contract,
      human: keeper.human,
      organization: team.organization,
      from: date,
      to: date+1.year
    expect(current_team_structure).to eq TeamStructure.new(1,0,0,0)
  end

end

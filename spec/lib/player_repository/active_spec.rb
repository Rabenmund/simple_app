require 'spec_helper'

RSpec.describe PlayerRepository::Active do
  let(:date) { Date.new(2015,7,1) }

  before do
    @player1 = create :player
    @player2 = create :player, retired: true
    @player3 = create :player
    team = create :team
    create :contract,
      human: @player3.human,
      organization: team.organization,
      from: date - 1.year,
      to: date
  end

  it "provides the active players at a date" do
    expect(PlayerRepository::Active.for_teams_at(teams: Team.all, date: date))
      .to include @player1
    expect(PlayerRepository::Active.for_teams_at(teams: Team.all, date: date))
      .to include @player3
  end

end

require 'spec_helper'

RSpec.describe PlayerRepository::ContractedFinder do
  let(:date) { Date.new(2015,7,1) }
  let(:team) { create :team }
  let(:team2) { create :team }

  before do
    @player1 = create :player
    @player2 = create :player, retired: true
    @player3 = create :player
    create :contract,
      human: @player3.human,
      organization: team.organization,
      from: date - 1.year,
      to: date
    @player4 = create :player
    create :contract,
      human: @player4.human,
      organization: team2.organization,
      from: date - 1.year,
      to: date
  end

  it "finds all contracted players at a date" do
    expect(PlayerRepository::ContractedFinder.at(date))
      .to include @player3
    expect(PlayerRepository::ContractedFinder.at(date))
      .to include @player4
  end

  it "finds all contracted players for a team at a date" do
    expect(PlayerRepository::ContractedFinder
      .for_team_at(team: team, date: date))
      .to eq [@player3]
  end

  it "finds all contracted players for teams at a date" do
    expect(PlayerRepository::ContractedFinder
      .for_teams_at(teams: [team], date: date))
      .to eq [@player3]
  end
end


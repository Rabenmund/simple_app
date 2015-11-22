require 'spec_helper'

RSpec.describe LeagueUseCase::FillUpWithTeams do
  subject(:filler) { described_class }
  let(:league) { create :league }

  it "fills up missing teams" do
    team1 = create :team
    team2 = create :team
    allow(TeamRepository::AvailableForLeague)
      .to receive(:new)
      .and_return(double("Availables", random: [team1, team2]))
    filler.new(league: league, size: 2).random
    expect(league.teams).to contain_exactly team1, team2
  end

  it "does not add teams if not necessary" do
    filler.new(league: league, size: 0).random
    expect(TeamRepository::AvailableForLeague)
      .to_not receive :new
  end

end

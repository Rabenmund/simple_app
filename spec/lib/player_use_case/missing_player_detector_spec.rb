require_relative(
  '../../../lib/player_use_case/missing_player_detector'
)
require_relative '../../../lib/player_repository/factory'
require_relative '../../../lib/player_repository/active'
require_relative '../../../lib/team_repository/active'

RSpec.describe PlayerUseCase::MissingPlayerDetector do
  subject(:detector) do
    PlayerUseCase::MissingPlayerDetector.new(date: date)
  end
  let(:date) { Date.new(2016,7,1) }
  let(:teams) { double("ActiveTeams", size: 2) }

  before do
    allow(PlayerRepository::Active)
      .to receive(:for_teams_at)
      .with(teams: teams, date: date)
      .and_return double("ActivePlayers", count: 48)
    allow(TeamRepository::Active)
      .to receive(:at)
      .with(date)
      .and_return teams
  end

  it "produces missing players at at special date" do
    expect(PlayerRepository::Factory)
      .to receive(:new)
      .exactly(2).times
      .and_return(double("Factory", create: true))
    detector.generate_players
  end

end

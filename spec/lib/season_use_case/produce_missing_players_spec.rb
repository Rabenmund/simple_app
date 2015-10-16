require_relative(
  '../../../lib//season_use_case/produce_missing_players'
)
require_relative '../../../lib/player_repository/factory'
require_relative '../../../lib/player_repository/active'
require_relative '../../../lib/team_repository/active'

RSpec.describe SeasonUseCase::ProduceMissingPlayers do
  subject(:production) do
    SeasonUseCase::ProduceMissingPlayers
  end
  let(:date) { Date.new(2016,7,1) }

  before do
    allow(PlayerRepository::Active)
      .to receive(:at)
      .with(date)
      .and_return double("ActivePlayers", count: 48)
    allow(TeamRepository::Active)
      .to receive(:at)
      .with(date)
      .and_return double("ActiveTeams", count: 2)
  end

  it "produces missing players at at special date" do
    expect(PlayerRepository::Factory)
      .to receive(:create)
      .exactly(2).times
    production.at date
  end

end

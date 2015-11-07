require_relative '../../../lib/league_repository/ranking'
require_relative '../../../lib/league_repository/superleague'
require_relative '../../../lib/league_use_case/relegators'

RSpec.describe LeagueUseCase::Relegators do
  subject(:relegators) { LeagueUseCase::Relegators.new(league: league) }
  let(:league) { double "League" }
  let(:superleague) { double "Superleague" }

  it "asks for the teams being no promoter or relgator" do
    ranker = double "Ranker"
    expect(LeagueRepository::Ranking)
      .to receive(:new)
      .with(league: superleague)
      .and_return ranker
    expect(ranker)
      .to receive(:last)
      .with(666)
    allow(LeagueRepository::Superleague)
      .to receive(:find_for)
      .with(league)
      .and_return superleague
    relegators.last 666
  end
end

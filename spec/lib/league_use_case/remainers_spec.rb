require_relative '../../../lib/league_repository/ranking'
require_relative '../../../lib/league_use_case/remainers'

RSpec.describe LeagueUseCase::Remainers do
  subject(:remainers) { LeagueUseCase::Remainers.new(league: league) }
  let(:league) { double "League" }

  it "asks for the teams being no promoter or relgator" do
    ranker = double "Ranker"
    expect(LeagueRepository::Ranking)
      .to receive(:new)
      .with(league: league)
      .and_return ranker
    expect(ranker)
      .to receive(:from)
      .with(4, 12)
    remainers.from promoters_no: 3, size: 12
  end
end
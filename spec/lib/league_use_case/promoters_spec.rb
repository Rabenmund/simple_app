require_relative '../../../lib/league_repository/ranking'
require_relative '../../../lib/league_repository/subleagues'
require_relative '../../../lib/league_use_case/promoters'

RSpec.describe LeagueUseCase::Promoters do
  subject(:relegators) { LeagueUseCase::Promoters.new(league: league) }
  let(:league) { double "League" }
  let(:sub1) { double "Subleague 1" }
  let(:sub2) { double "Subleague 2" }

  it "asks for the teams being no promoter or relgator" do
    ranker = double "Ranker", first: [:team]
    expect(LeagueRepository::Ranking)
      .to receive(:new)
      .with(league: sub1)
      .and_return ranker
    expect(LeagueRepository::Ranking)
      .to receive(:new)
      .with(league: sub2)
      .and_return ranker
    allow(LeagueRepository::Subleagues)
      .to receive(:find_all_for)
      .with(league)
      .and_return [sub1, sub2]
    expect(relegators.first(2)).to eq [:team, :team]
  end

  it "does not provide promoters if there is an expectation mismatch" do
    allow(LeagueRepository::Subleagues)
      .to receive(:find_all_for)
      .with(league)
      .and_return [sub1]
    expect{relegators.first(2)}
      .to raise_error{LeagueUseCase::SubleaguesDoNotMatchPromotersNumberError}
  end
end

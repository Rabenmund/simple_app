require 'spec_helper'

RSpec.describe LeagueRepository::StartDate do
  subject(:repo) { LeagueRepository::StartDate.new(id: league.id) }
  let(:league) { create :league, start: Date.new(2015,7,1) }

  it "provides the start date" do
    expect(repo.start_date).to eq league.start
  end
end

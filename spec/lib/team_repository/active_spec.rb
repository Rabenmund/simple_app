require 'spec_helper'

RSpec.describe TeamRepository::Active do
  subject(:actives) { TeamRepository::Active }
  let(:season) do
    create :season,
      start_date: Date.new(2015,7,1), end_date: Date.new(2016,6,30)
  end
  let(:active1) { create :team }
  let(:active2) { create :team }

  before do
    season2 = create :season,
      start_date: Date.new(2014,7,30), end_date: Date.new(2015,6,30)
    not_longer_active = create :team
    league2 = create :league, season: season2
    league2.teams << not_longer_active
    inactive = create :team
    league = create :league, season: season
    league.teams << active1
    league.teams << active2
  end

  it "provides all active teams at a date" do
    expect(actives.at(Date.new(2015,12,1))).to include active1
    expect(actives.at(Date.new(2015,12,1))).to include active2
  end

end


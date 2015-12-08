require 'spec_helper'

RSpec.describe LeagueUseCase::GamePlanCalender do
  subject(:calender) { described_class.new(league: league) }
  let(:league) { double "League", season: season, teams: teams, level: 1 }
  let(:season) { double "Season", year: 2016 }
  let(:teams) { [:t1, :t2, :t3, :t4, :t5, :t6, :t7, :t8, :t9, :t10, :t11,
                 :t12, :t13, :t14, :t15, :t16, :t17, :t18] }

  it "has a number of planned matchdays" do
    matchdays = calender.matchdays
    expect(matchdays.size).to eq 34
    expect(matchdays.first.attributes)
      .to eq(number: 1, start: Date.new(2015,8,8))
    expect(matchdays.first.games.size).to eq 9
    expect(matchdays.first.games.first.attributes)
      .to eq(home_id: 1, guest_id: 10)
  end

  it "fails when the number of teams is not valid" do
    allow(league).to receive(:teams).and_return [:team]
    expect{ calender.matchdays }
      .to raise_error LeagueUseCase::TeamsSizeError
  end

end

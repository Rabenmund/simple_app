require 'spec_helper'

RSpec.describe CompetitionUseCase::GamePlanCalender do
  subject(:calender) { described_class.new(competition: league, type: :league) }
  let(:league) { double "League", season: season, teams: teams, level: 1 }
  let(:season) { double "Season", year: 2016 }
  let(:teams) { [:t1, :t2, :t3, :t4, :t5, :t6, :t7, :t8, :t9, :t10, :t11,
                 :t12, :t13, :t14, :t15, :t16, :t17, :t18] }

  it "has a number of planned matchdays" do
    matchdays = calender.matchdays
    expect(matchdays.size).to eq 17
  end

  it "misses some tests"
end

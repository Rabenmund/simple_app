require 'spec_helper'

RSpec.describe SeasonUseCase::GameStart do
  subject(:start) { described_class }
  let(:matchday_start) { DateTime.new(2015,8,8,15,30) }

  it "has a date for the first game of league 1" do
    expect(start.date_time(type: :league,
                           level: 1,
                           matchday_start: matchday_start,
                           md_number: 1,
                           g_number: 0))
      .to eq DateTime.new(2015,8,7,20,30)
  end

  it "has a date for the last game of league 2" do
    expect(start.date_time(type: :league,
                           level: 2,
                           matchday_start: matchday_start+1.day,
                           md_number: 1,
                           g_number: 8))
      .to eq DateTime.new(2015,8,10,20,30)
  end

  it "has a date for the first game of first round of a cup" do
    expect(start.date_time(type: :cup,
                           level: 1,
                           matchday_start: matchday_start+7.days,
                           md_number: 1,
                           g_number: 1))
      .to eq DateTime.new(2015,8,14,18,30)
  end

  it "has a date for the cup final" do
    expect(start.date_time(type: :cup,
                           level: 1,
                           matchday_start: matchday_start+294.days,
                           md_number: 6,
                           g_number: 1))
      .to eq DateTime.new(2016,5,28,20,30)
  end

  it "has a date for the second national game of a matchday" do
    expect(start.date_time(type: :national,
                           matchday_start: matchday_start+14.days,
                           md_number: 2,
                           g_number: 2))
      .to eq DateTime.new(2015,8,22,20,30)
  end

  it "has a date for the second half final of a national cup" do
    expect(start.date_time(type: :national_cup,
                           level: 1,
                           matchday_start: matchday_start+318.days,
                           md_number: 6,
                           g_number: 1))
      .to eq DateTime.new(2016,6,21,20,30)
  end
end

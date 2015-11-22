require 'spec_helper'

RSpec.describe SeasonUseCase::MatchdayStart do
  subject(:start) { described_class }

  it "finds the correct date for a level 1 league matchday" do
    expect(
      start.date_for(
        type: :league,
        number_all: 34,
        competition_start: Date.new(2015,8,8),
        number: 34,
        level: 1
      )
    )
    .to eq Date.new(2016,5,21)
  end

  it "finds the correct date for a level 2 league matchday" do
    expect(
      start.date_for(
        type: :league,
        number_all: 34,
        competition_start: Date.new(2015,8,8),
        number: 1,
        level: 2
      )
    )
    .to eq Date.new(2015,8,9)
  end

  it "finds the correct date for a level 3 league matchday" do
    expect(
      start.date_for(
        type: :league,
        number_all: 34,
        competition_start: Date.new(2015,8,8),
        number: 34,
        level: 3
      )
    )
    .to eq Date.new(2016,5,22)
  end

  it "finds the correct date for a cup matchday" do
    expect(
      start.date_for(
        type: :cup,
        number_all: 6,
        competition_start: Date.new(2015,8,8),
        number: 2
      )
    )
    .to eq Date.new(2015,10,20)
  end

  it "finds the correct date for a national matchday" do
    expect(
      start.date_for(
        type: :national,
        number_all: 10,
        competition_start: Date.new(2015,8,8),
        number: 8
      )
    )
    .to eq Date.new(2016,2,27)
  end

  it "finds the correct date for a national cup matchday" do
    expect(
      start.date_for(
        type: :national_cup,
        number_all: 7,
        competition_start: Date.new(2015,8,8),
        number: 7
      )
    )
    .to eq Date.new(2016,6,25)
  end
end


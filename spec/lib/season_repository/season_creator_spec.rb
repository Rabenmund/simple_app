require 'spec_helper'

RSpec.describe SeasonRepository::SeasonCreator do
  subject(:creator) do
    SeasonRepository::SeasonCreator.new(previous: previous)
  end
  let(:previous) { create :season, year: 2014 }
  let(:season) { create :season, year: 2015 }
  let(:fed1) { create :federation }
  let(:fed2) { create :federation }

  before do
    allow(Season).to receive(:create).and_return season
    previous.federations << fed1 << fed2
    create :competition_plan, federation: fed1
    create :competition_plan, federation: fed2
  end

  it "creates the next season according to competition plans" do
    allow(previous).to receive(:next_one).and_return nil
    expect(LeagueUseCase::LeaguePlanner)
      .to receive(:new)
      .with(season: season, previous: previous, federation: fed1)
      .and_return double("Creator1", with_plan: true)
    expect(LeagueUseCase::LeaguePlanner)
      .to receive(:new)
      .with(season: season, previous: previous, federation: fed2)
      .and_return double("Creator2", with_plan: true)
    expect(CupUseCase::CupPlanner)
      .to receive(:new)
      .with(season: season, previous: previous, federation: fed1)
      .and_return double("Creator3", with_plan: true)
    expect(CupUseCase::CupPlanner)
      .to receive(:new)
      .with(season: season, previous: previous, federation: fed2)
      .and_return double("Creator4", with_plan: true)
    next_season = creator.create_with_competitions
  end

  it "does not create a next season if there is already one" do
    season
    expect{creator.create_with_competitions}.to raise_error(
      SeasonRepository::SeasonAlreadyCreatedError)
  end

end

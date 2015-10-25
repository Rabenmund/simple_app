require_relative "../../../lib/season_use_case/event_planner"

RSpec.describe SeasonUseCase::EventPlanner do
  subject(:planner) { SeasonUseCase::EventPlanner.new(season: :season) }
  before do
    allow(SeasonEventing::FinishPlayerExchangeCreator).to receive :for_season
    allow(SeasonEventing::HalfTimeCreator).to receive :for_season
    allow(SeasonEventing::TearDownCreator).to receive :for_season
  end

  it "creates a half time event" do
    expect(SeasonEventing::HalfTimeCreator)
      .to receive(:for_season)
      .with(:season)
    planner.call
  end

  it "creates a tear down event" do
    expect(SeasonEventing::TearDownCreator)
      .to receive(:for_season)
      .with(:season)
    planner.call
  end

  it "creates a finish player exchange event" do
    expect(SeasonEventing::FinishPlayerExchangeCreator)
      .to receive(:for_season)
      .with(:season)
    planner.call
  end
end

require_relative "../../../lib/season_use_case/event_planner"

RSpec.describe SeasonUseCase::EventPlanner do
  subject(:planner) { SeasonUseCase::EventPlanner.new(season: :season) }

  it "creates a finish player exchange event"

  it "creates a half time event" do
    expect(SeasonEventing::HalfTimeCreator)
      .to receive(:for_season)
      .with(:season)
    planner.call
  end

  it "creates a tear down event"
end

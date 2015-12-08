require "spec_helper"

shared_examples_for SeasonEventable do
  let!(:season_event) {create :season_event, eventable: testable }

  it "and has a valid season_eventable" do
    expect(season_event).to be_valid
  end
end

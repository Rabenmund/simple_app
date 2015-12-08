require 'spec_helper'

RSpec.describe CupUseCase::CupPlanner do
  subject(:planner) { described_class.new(season: season, previous: previous_season, federation: federation) }

  let(:season) { double "Season" }
  let(:previous_season) { double "Previous" }
  let(:federation) { double "Federation" }
  let(:creator) { double "Creator" }

  it "calls the cup creator per plan" do
    expect(CupRepository::CupCreator)
      .to receive(:new)
      .with(season: season, previous: previous_season, federation: federation)
      .and_return creator
    expect(creator)
      .to receive(:by_plan)
      .with(:plan1)
      .and_return :cup1
    expect(creator)
      .to receive(:by_plan)
      .with(:plan2)
      .and_return :cup2
    expect(planner.with_plan([:plan1, :plan2]))
      .to eq [:cup1, :cup2]
  end
end

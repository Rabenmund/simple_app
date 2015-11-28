require 'spec_helper'

RSpec.describe CompetitionPlanning::DfbPlan do
  subject(:plan) { create :dfb_plan }

  it "is valid" do
    expect(plan).to be_valid
  end

  it "has leagues" do
    expect(plan.leagues.size).to eq 3
  end

  it "has cups" do
    expect(plan.cups.size).to eq 1
  end

  it "has qualifies" do
    expect(plan.cups.first.qualified.leagues[4]).to eq 10
  end
end

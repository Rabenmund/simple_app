require 'spec_helper'

RSpec.describe CompetitionPlan do
  subject(:competition_plan) { create :dfb_plan }

  it "is valid" do
    expect(competition_plan).to be_valid
  end
end

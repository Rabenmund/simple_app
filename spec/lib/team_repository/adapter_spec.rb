require 'spec_helper'

RSpec.describe TeamRepository::Adapter do
  subject(:adapter) { TeamRepository::Adapter.new(id: team.id) }
  let(:team) { create :team }

  it "adapts to team object" do
    expect(adapter.team).to eq team
  end

  it "adapts to organization object" do
    expect(adapter.organization).to eq team.organization
  end
end

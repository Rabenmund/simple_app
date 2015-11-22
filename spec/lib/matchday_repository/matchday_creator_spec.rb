require 'spec_helper'

RSpec.describe MatchdayRepository::MatchdayCreator do
  subject(:creator) { described_class }
  let(:league) { create :league }

  it "creates a matchday" do
    matchday = creator.create(
      number: 1,
      start: DateTime.new(2015,8,8,15,30),
      competition: league
    )
    expect(matchday).to be_valid
  end
end

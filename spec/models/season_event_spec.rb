require 'spec_helper'

RSpec.describe SeasonEvent do
  class TestEvent < SeasonEvent; end

  let(:event) { TestEvent.create(season: season) }
  let(:season) { create :season }

  it "is valid" do
    expect(event).to be_a SeasonEvent
    expect(event).to be_valid
  end
end

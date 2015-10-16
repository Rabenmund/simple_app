require 'spec_helper'

RSpec.describe Season do
  let(:season) { create :season }

  it "is valid" do
    expect(season).to be_valid
  end
end

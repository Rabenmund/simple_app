require 'spec_helper'

describe InitialStrength do
  it "has a strength for a young" do
    expect(InitialStrength.for_age(6800)).to be_a Integer
  end
end

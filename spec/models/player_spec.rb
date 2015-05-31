require 'spec_helper'

describe Player do

  let(:player) { create :player }

  it "is valid" do
    expect(player).to be_valid
  end
end

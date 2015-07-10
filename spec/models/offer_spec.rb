require 'spec_helper'

describe Offer do
  let(:offer) { create :offer }

  it "is valid" do
    expect(offer).to be_valid
  end
end

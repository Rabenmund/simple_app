require 'spec_helper'

describe Teardown do
  let(:teardown) { create :teardown }
  it "is valid" do
    expect(teardown).to be_valid
  end
end

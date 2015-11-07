require 'spec_helper'

RSpec.describe Result do
  let(:result) { create :result }

  it "is valid" do
    expect(result).to be_valid
  end
end

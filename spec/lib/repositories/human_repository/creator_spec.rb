require 'spec_helper'

RSpec.describe HumanRepository::Creator do
  it "creates an human" do
    params = {
      name: "Franz Beckenbauer",
      birthday: Date.new(1969,3,31)
    }
    player = HumanRepository::Creator.create(params)
    expect(player).to be_valid
    expect(player.name).to eq "Franz Beckenbauer"
  end
end

require 'spec_helper'

RSpec.describe PlayerRepository::Creator do
  it "creates an player" do
    human = create :human
    params = {
      human: human,
      defense: 100
    }
    player = PlayerRepository::Creator.create(params)
    expect(player).to be_valid
    expect(player.defense).to eq 100
  end
end


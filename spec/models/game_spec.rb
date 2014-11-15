require "spec_helper"

describe Game do
  let(:game) {create :game}
  let(:testable) {game}

  it_behaves_like Appointable

  it "is valid" do
    expect(game).to be_valid
  end
end

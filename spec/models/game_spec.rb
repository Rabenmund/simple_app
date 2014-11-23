require "spec_helper"

describe Game do
  let(:game) {create :game}
  let(:testable) {game}

  it_behaves_like Appointable

  it "is valid" do
    expect(game).to be_valid
  end

  it "finishes" do
    game.update_attributes(home_goals: 1, guest_goals: 1)
    game.finish!
    expect(game.finished).to eq true
    expect(game.reload.appointment).to eq nil
  end
end

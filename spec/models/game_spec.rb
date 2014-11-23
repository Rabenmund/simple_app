require "spec_helper"

describe Game do
  let(:game) {create :game, home_goals: 1, guest_goals: 1}
  let(:testable) {game}

  it_behaves_like Appointable

  it "is valid" do
    expect(game).to be_valid
  end

  it "finishes" do
    game.finish!
    expect(game.finished).to eq true
    expect(game.reload.appointment).to eq nil
  end

  it "does not finish a game having no goals" do
    game.update_attributes(home_goals: nil)
    expect(game.finish!).to eq false
  end

  it "finishes a game two times successfully" do
    game.finish!
    expect(game.finish!).to eq true
  end

  context "#perform!" do
    it "updates the performed_at time" do
      expect{game.perform!}.to change{game.performed_at}.by(1.minute)
    end

    it "does not perform an already finished game" do
      game.finish!
      expect(game.perform!).to eq false
    end
  end
end

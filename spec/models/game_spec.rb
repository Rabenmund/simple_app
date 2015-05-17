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
    it "does not perform an already finished game" do
      game.finish!
      expect(game.perform!).to eq false
    end

    it "updates the seconds" do
      expect{game.perform!}.to change{game.second}.by(60)
    end

    it "calls the Eventer" do
      expect(GameEventer).to receive(:new).and_return double(perform!: :evented)
      game.perform!
    end

    it "does not call the Eventer is the is paused in first half" do
      game.update_attributes(second: 3300, half_second: 2700)
      expect(GameEventer).to_not receive(:new)
      game.perform!
    end

    it "finishes first half" do
      game.update_attributes(second:2700)
      5.times {game.perform!}
      expect(game.half_second).to_not be_nil
    end

    it "does not finish the first half if it is already finished" do
      game.finish!
      game.update_attributes(second: 2700)
      5.times {game.perform!}
      expect(game.half_second).to be_nil
    end

    it "does not finish the first half if there is still additional time" do
      game.update_attributes(second: 2760)
      allow(game).to receive(:additional_time?).and_return true
      game.perform!
      expect(game.half_second).to be_nil
    end

    it "finishes second half" do
      game.update_attributes(second: 6300)
      10.times {game.perform!}
      expect(game.full_second).to_not be_nil
    end

    it "does not finish the second half if it is already finished" do
      game.finish!
      game.update_attributes(second: 6300)
      10.times {game.perform!}
      expect(game.full_second).to be_nil
    end

    it "does not finish the second half if there is still additional time" do
      game.update_attributes(second: 6360)
      allow(game).to receive(:additional_time?).and_return true
      game.perform!
      expect(game.full_second).to be_nil
    end

    it "finished a game" do
      game.update_attributes(second: 7000)
      game.perform!
      expect(game.finished).to eq true
      expect(game.reload.appointment).to be_nil
    end

    it "does not finish a game that's second half is not finished" do
      game.update_attributes(second: 6300)
      allow(game).to receive(:additional_time?).and_return true
      game.perform!
      expect(game.finished).to eq false
      expect(game.reload.appointment).to_not be_nil
    end
  end

  it "has a current date time" do
    game.update_attributes(second: 60)
    expect(game.current_date_time).to eq game.performed_at+60
  end

  it "knows whether it is started" do
    expect(game.started?).to eq false
  end
end

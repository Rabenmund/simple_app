require "spec_helper"

describe Draw do
  let(:cup) { create :cup }
  let(:matchday) { create :matchday, competition: cup }
  let(:draw) { create :draw, cup: cup, matchday: matchday }

  it "is valid" do
    expect(draw).to be_valid
  end

  it "has a competition called cup" do
    expect(draw.competition).to be_a Cup
  end

  it "has a season" do
    expect(draw.season).to eq draw.competition.season
  end

  it "finishes the draw" do
    expect{draw.finish!}.to change{draw.finished}.from(false).to(true)
  end

  it "destroys its appointment if finishing" do
    expect{draw.finish!}.to change{draw.reload.appointment}.from(draw.appointment).to nil
  end

  it "is finished" do
    draw.finish!
    expect(draw.finished?).to eq true
  end

  it "is not finished" do
    expect(draw.finished?).to eq false
  end

  it "does not perform a finished draw" do
    draw.finish!
    expect(draw.perform!).to eq false
  end

  context "#perform!" do
    before do
      @team1 = create :team
      @team2 = create :team
      @team3 = create :team
      7.times { create :team }
      allow(cup).to receive(:teams).and_return Team.all
      allow(cup).to receive(:drawed_teams_at).and_return (Team.all - [@team1, @team3])
    end

    it "does not include already drawed teams" do
      expect(draw.perform!).to include @team1
    end

    it "increases the minutes by 1" do
      performed = draw.performed_at
      draw.perform!
      expect(draw.performed_at).to eq performed+1.minute
    end

    it "creates a game" do
      expect{draw.perform!}.to change{Game.count}.by(1)
    end
  end

end

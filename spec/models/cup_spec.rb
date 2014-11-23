require "spec_helper"

describe Cup do
  let(:cup) { create :cup }

  it "is valid" do
    expect(cup).to be_valid
  end

  it "prepares a new season for 64 members" do
    allow(cup).to receive(:members).and_return double(size: 64)
    cup.prepare!
    expect(cup.matchdays.pluck(:number)).to eq [1,2,3,4,5,6]
    expect(cup.draws.count).to be 6
  end

  it "prepares a new season for an invalid members size" do
    allow(cup).to receive(:members).and_return double(size: 99)
    expect{cup.prepare!}.to change{cup.matchdays.count}.by 0
    expect{cup.prepare!}.to change{cup.draws.count}.by 0
  end

  context "#scopes " do
    before do
      @matchday = create :matchday, competition: cup, number: 2
      @team1 = create :team
      game1 = create :game, home_goals: 1, guest_goals: 0, matchday: @matchday
      @team2 = game1.home
      @team3 = game1.guest
      game2 = create :game, home_goals: 2, guest_goals: 3, matchday: @matchday
      @team4 = game2.home
      @team5 = game2.guest
      cup.teams << Team.all
    end

    it "has winning teams for a matchday" do
      expect(cup.winning_teams_at @matchday).to eq [@team2, @team5]
    end

    it "has drawed teams at matchday" do
      expect(cup.drawed_teams_at @matchday).to eq [@team2, @team3, @team4, @team5]
    end
  end
end

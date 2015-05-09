require 'spec_helper'

describe Matchday do

  let(:matchday) { create :matchday }
  let(:game) { create :game, matchday: matchday }

  it "is valid" do
    expect(matchday).to be_valid
  end

  it "scopes unfinished matchdays" do
    game
    matchday_without_games = create(
      :matchday, competition: matchday.competition)
    matchday_with_finished_games = create(
      :matchday, competition: matchday.competition)
    finished_game = create :game, matchday: matchday_with_finished_games
    finished_game.update_attributes(home_goals: 1, guest_goals:0)
    finished_game.finish!
    matchday_with_finished_games.games << finished_game
    expect(Matchday.unfinished).to eq [game.matchday]
  end

  it "perform!" do
    game
    expect(matchday.perform!).to eq true
  end

  it "has games" do
    game
    expect(matchday.has_games?).to eq true
  end

  it "has a next appointment" do
    game
    another_game = create :game, matchday: matchday
    expect(matchday.next_appointable).to eq game
  end

  it "is not finished without games" do
    expect(matchday.finished?).to eq false
  end

  it "is not finished without all games finished" do
    game
    expect(matchday.finished?).to eq false
  end

  it "is finished with all games finished" do
    game.update_attributes(home_goals: 1, guest_goals: 0)
    game.finish!
    expect(matchday.finished?).to eq true
  end

end

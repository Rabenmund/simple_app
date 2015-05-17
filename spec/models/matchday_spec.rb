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

  it "has the next appointment date as current date time" do
    game
    expect(matchday.current_date_time).to eq game.appointment.appointed_at
  end

  it "has the latest game date as current date time" do
    game
    game.appointment.delete
    game.update_attributes(second: 60)
    expect(matchday.current_date_time).to eq game.performed_at+60
  end

  it "has its start date as current date time" do
    expect(matchday.current_date_time).to eq matchday.start
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

  it "has board" do
    league = create :league
    matchday = create :matchday, competition: league
    expect(matchday.has_board?).to eq true
  end

  it "has no board" do
    cup = create :cup
    matchday = create :matchday, competition: cup
    expect(matchday.has_board?).to eq false
  end

end

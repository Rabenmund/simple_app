require 'spec_helper'

RSpec.describe LeagueUseCase::GamesPlanner do
  subject(:planner) do
    LeagueUseCase::GamesPlanner.new(league: league)
  end
  let(:league) { double("League", id: 42) }
  let(:attributes) { {home_id: 1, guest_id: 1} }
  let(:calender) do
    double("Calender",
           matchdays: [matchday, matchday]
          )
  end
  let(:matchday) do
    double("Matchday",
           id: 1,
           games: [game, game],
           attributes: {attributes: attributes}
          )
  end
  let(:game) do
    double("Game",
           start: :start,
           attributes: {attributes: attributes}
          )
  end

  it "calls the game and matchday creators according GamePlanCalender" do
    expect(LeagueUseCase::GamePlanCalender)
      .to receive(:new)
      .with(league: league)
      .and_return calender
    expect(MatchdayRepository::MatchdayCreator)
      .to receive(:create)
      .with({attributes: attributes, competition_id: 42})
      .exactly(2).times
      .and_return matchday
    expect(GameRepository::GameCreator)
      .to receive(:create)
      .with(date: :start,
            attributes: {attributes: attributes, matchday_id: matchday.id})
      .exactly(4).times
    planner.call
  end

end

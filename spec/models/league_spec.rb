require 'spec_helper'

describe League do
  let(:league) { create :league }
  let(:matchday) { create :matchday, competition: league }
  let(:game) { create :game, matchday: matchday }

  # it 'prepares a league' do
  #   18.times do |n|
  #     team = create :team
  #     league.teams << team
  #   end
  #   league.prepare!
  #   expect(league.matchdays.count).to eq 34
  #   expect(league.games.count).to eq 306
  # end

  it "is not finished without games" do
    expect(league.finished?).to eq false
  end

  it "is not finished if it has not finished games" do
    expect(league.finished?).to eq false
  end

  it "is finished with finished games only" do
    game.update_attributes(finished: true)
    expect(league.finished?).to eq true
  end

  it "has a board" do
    allow(league).to receive(:points).and_return(
      double(board: :board)
    )
    expect(league.board).to eq :board
  end

  it "scopes by levels" do
    l1 = create :league, level: 1
    l2 = create :league, level: 2
    l3 = create :league, level: 3
    expect(League.by_levels([1,3])).to include l1
    expect(League.by_levels([1,3])).to include l3
    expect(League.by_levels([1,3])).to_not include l2
  end

end

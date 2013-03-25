require 'spec_helper'

describe Matchday do
    
  let(:matchday) { build :matchday }
  
  subject { matchday }
  
  it { should be_valid }
  it { should belong_to :competition }
  it { should have_many(:games).dependent :destroy }
  it { should validate_presence_of :number }
  it { should validate_numericality_of :number }
  it { should allow_mass_assignment_of :number }
  
  it "should validate uniqueness of :number scoped to competition" do
    matchday.save
    should validate_uniqueness_of(:number).scoped_to(:competition_id)
  end
  
  it "is finished when all games are finished" do
    game = create :finished_game
    game.matchday.should be_finished
  end
  
  it "is not finished when not all games are finished" do
    game = create :finished_game
    game2 = create :game, home_id: game.home_id, guest_id: game.guest_id, matchday: game.matchday
    game.matchday.should_not be_finished
  end
  
  # it ".finished lists all finished matchdays of my competition" do
  #   not_finished_game = create :game
  #   finished_game = create :finished_game
  #   finished_game.matchday.competition.matchdays.finished.should eq [finished_game.matchday]
  #   not_finished_game.matchday.competition.matchdays.finished.should eq []
  # end
  # 
  # it ".not_finished lists all not finished matchdays of my competition" do
  #   not_finished_game = create :game
  #   finished_game = create :finished_game
  #   finished_game.matchday.competition.matchdays.not_finished.should eq []
  #   not_finished_game.matchday.competition.matchdays.not_finished.should eq [not_finished_game.matchday]
  # end
  
  it "is not finished when no games exist" do
    should_not be_finished
  end
  
end

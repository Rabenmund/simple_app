require 'spec_helper'

describe Competition do
    
  let(:competition) { build :competition }
  
  subject { competition }
  
  it { should be_valid }
    
  it { should respond_to(:plan) }
  
  it { should have_db_column(:name).of_type(:string).with_options(null: false)}
  
  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :team_ids }
  it { should allow_mass_assignment_of :selected_matchday }
  
  it { should validate_presence_of :name }
  
  it { should have_and_belong_to_many :teams }
  it { should have_many(:matchdays).dependent :destroy }
  it { should belong_to :season }
  
  it "orders matchdays correctly" do
    matchday2 = create :matchday, number: 2
    matchday1 = create :matchday, competition: matchday2.competition, number: 1
    matchday2.competition.matchdays.first.should eq matchday1
  end
  
  it { should have_many(:games).through :matchdays }
    
  it "allows to associate correct number of teams" do
    competition.no_of_teams = 2
    2.times do
      team = build :team
      competition.teams << team
    end
    competition.should be_valid
  end
  
  it "does not allow to associate to more teams than no_of_teams" do
    competition.no_of_teams = 2
    3.times do
      team = build :team
      competition.teams << team
    end
    competition.should_not be_valid
  end
  
  its(:no_of_teams) { should eq 4 }
  its(:no_of_matchdays) { should eq 6 }
  its(:plan) { should eq [ [[1,2], [3,4]], [[1,4], [2,3]], [[3,1], [4,2]], [[2,1], [4,3]], [[4,1], [3,2]], [[1,3], [2,4]] ]}
  its(:plan_position) { should eq competition.reset_plan_position }
  
  it "resets plan_position to an arry with zeroes if not team is associated" do
    competition.reset_plan_position.should eq Array.new(competition.no_of_teams, 0)
  end
  
  it "resets plan_position with less than max teams associated" do
    competition.teams << create(:team)
    competition.reset_plan_position
    competition.plan_position[0].should eq competition.teams.first.id
    (competition.no_of_teams-1).times { |i| competition.plan_position[i+1].should eq 0 }
  end
  
  it "resets plan_position with max associated teams" do
    competition.no_of_teams.times { competition.teams << create(:team) }
    competition.reset_plan_position
    competition.no_of_teams.times { |i| competition.plan_position[i].should eq competition.teams[i].id }
  end
  
  it "updates the plan position" do
    competition.update_plan_position(0,666)
    competition.plan_position[0].should eq 666
  end
  
  it "does not randomize the plan positions without a team" do
    competition.randomize_plan_position
    competition.plan_position.should eq Array.new(competition.no_of_teams, 0)
  end
  
  it "randomizes the plan position with teams" do
    competition.no_of_teams.times { competition.teams << create(:team) }
    competition.randomize_plan_position
    competition.plan_position.should_not include 0
  end
  
  it "is ready_to_persist when the correct number of teams is associated" do
    competition.no_of_teams.times { competition.teams << create(:team) }
    competition.should be_ready_to_persist
  end
  
  it "is not ready_to_persist when not the correct number of teams is associated" do
    competition.should_not be_ready_to_persist
  end
  
  it "is started when first game has a result" do
    game = create :game
    game.home_goals = 1
    game.save
    game.competition.should be_started
  end
  
  it "is not started when first game has no result" do
    game = create :game
    game.home_goals.should be_nil
    game.competition.should_not be_started
  end
  
  it "is not started when no matchdays exist" do
    competition.matchdays.should be_empty
    competition.should_not be_started
  end
  
  it "is finished when all matchdays are finished" do
    finished_game = create :finished_game
    finished_game.competition.should be_finished
  end
  
  it "is not finished when not all matchdays are finished" do
    finished_game = create :finished_game
    another_matchday = create :matchday, competition: finished_game.competition
    finished_game.competition.should_not be_finished
  end
  
end
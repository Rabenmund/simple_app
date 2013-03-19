require 'spec_helper'

describe Competition do
    
  let(:competition) { build :competition }
  
  subject { competition }
  
  it { should be_valid }
  
  its(:no_of_teams) { should eq 4 }
  
  it { should respond_to(:plan) }
  
  it { should have_db_column(:name).of_type(:string).with_options(null: false)}
  
  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :team_ids }
  it { should allow_mass_assignment_of :selected_matchday }
  
  it { should validate_presence_of :name }
  
  it { should have_and_belong_to_many :teams }
  it { should have_many(:matchdays).dependent :destroy }
  it { should have_many(:games).through :matchdays }
    
  it "should allow to associate correct number of teams" do
    competition.no_of_teams = 2
    2.times do
      team = build :team
      competition.teams << team
    end
    competition.should be_valid
  end
  
  it "should not allow to associate to more teams than no_of_teams" do
    competition.no_of_teams = 2
    3.times do
      team = build :team
      competition.teams << team
    end
    competition.should_not be_valid
  end
  
end
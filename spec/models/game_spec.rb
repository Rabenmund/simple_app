require 'spec_helper'

describe Game do
    
  let(:game) { create :game } 
  
  subject { game }
  
  it { should be_valid }
  
  it { should have_db_column(:home_id).of_type(:integer).with_options(null: false)}
  it { should have_db_column(:guest_id).of_type(:integer).with_options(null: false)}
  it { should have_db_column(:home_goals).of_type(:integer)}
  it { should have_db_column(:guest_goals).of_type(:integer)}

  it { should have_db_index :home_id }
  it { should have_db_index :guest_id }
  
  it { should allow_mass_assignment_of :home_id }
  it { should allow_mass_assignment_of :guest_id }
  it { should allow_mass_assignment_of :home_goals }
  it { should allow_mass_assignment_of :guest_goals }
  
  it { should validate_presence_of :home_id }
  it { should validate_presence_of :guest_id }
  
  it { should validate_numericality_of :home_id }
  it { should validate_numericality_of :guest_id }
  it { should validate_numericality_of :home_goals }
  it { should validate_numericality_of :guest_goals }
  
  it { should have_one(:competition).through :matchday }
  it { should belong_to :matchday }
  
  it "is finished when all goals are valued" do
    game.home_goals, game.guest_goals = 1 , 1 
    should be_finished 
  end
  
  it "is not finished when a goal value is missing" do
    game.home_goals = 1 
    should_not be_finished
  end
  
end
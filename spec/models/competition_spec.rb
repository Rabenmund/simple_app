require 'spec_helper'

describe Competition do
    
  let(:competition) { build :competition } 
  
  subject { competition }
  
  it { should be_valid }
  
  its(:no_of_teams) { should eq 6 }
  
  it { should respond_to(:plan) }
  
  it { should have_db_column(:name).of_type(:string).with_options(null: false)}
  
  it { should allow_mass_assignment_of :name }
  
  it { should validate_presence_of :name }
  
  it { should have_and_belong_to_many :teams }
  
end
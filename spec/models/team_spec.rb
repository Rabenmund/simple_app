require 'spec_helper'

describe Team do
    
  let(:team) { build :team } 
  
  subject { team }
  
  it { should be_valid }
  
  it { should have_db_column(:name).of_type(:string).with_options(null: false)}
  
  it { should allow_mass_assignment_of :name }
  
  it { should validate_presence_of :name }
  
  it { should have_and_belong_to_many :competitions }
  
end
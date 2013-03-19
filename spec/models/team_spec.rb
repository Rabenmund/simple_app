require 'spec_helper'

describe Team do
    
  let(:team) { build :team } 
  
  subject { team }
  
  it { should be_valid }
  
  it { should have_db_column(:name).of_type(:string).with_options(null: false)}
  it { should have_db_column(:short_name).of_type(:string).with_options(null: false)}
  it { should have_db_column(:abbreviation).of_type(:string).with_options(null: false)}
  
  it { should allow_mass_assignment_of :name }
  it { should allow_mass_assignment_of :short_name }
  it { should allow_mass_assignment_of :abbreviation }
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :short_name }
  it { should validate_presence_of :abbreviation }
  
  it { should ensure_length_of(:name).is_at_most(30) }
  it { should ensure_length_of(:short_name).is_at_most(8) }
  it { should ensure_length_of(:abbreviation).is_at_most(3) }
  
  it { should have_and_belong_to_many :competitions }
  
end
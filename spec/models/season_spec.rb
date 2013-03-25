require 'spec_helper'

describe Season do
    
  let(:season) { build :season }
  
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should ensure_length_of(:name).is_at_most(30) }
  
  it { should have_many :competitions }
  it { should allow_mass_assignment_of :name }
  
end
require 'spec_helper'

describe Season do
    
  let(:season) { build :season }
  
  it { should have_db_column(:name).of_type(:string).with_options(null: false) }
  it { should ensure_length_of(:name).is_at_most(30) }
  
  it { should have_many :competitions }
  it { should allow_mass_assignment_of :name }
  
  describe "#finished?" do
    
    before do
      @com1 = double "Competition1", finished?: true
      @com2 = double "Competition2", finished?: true
      Season.any_instance.stub(competitions: [@com1, @com2])
    end
    
    it "is finished when all competitions are finished" do
      should be_finished
    end 
  
    it "is not finished when not all competitions are finished" do
      @com2.stub(finished?: false)
      should_not be_finished
    end
  end
end
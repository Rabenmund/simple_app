require 'spec_helper'

describe Matchday do
    
  let(:matchday) { build :matchday }
  
  subject { matchday }
  
  it { should be_valid }
  it { should belong_to :competition }
  it { should have_many(:games).dependent :destroy }
  it { should validate_presence_of :number }
  it { should validate_numericality_of :number }
  
  it "should validate uniqueness of :number scoped to competition" do
    matchday.save
    should validate_uniqueness_of(:number).scoped_to(:competition_id)
  end
  
end

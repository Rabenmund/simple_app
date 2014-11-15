require 'spec_helper'

describe Team do

  let(:team) { build :team }

  subject { team }

  it { should be_valid }

  it { should have_and_belong_to_many :competitions }

end

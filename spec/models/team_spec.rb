require 'spec_helper'

describe Team do

  let(:team) { build :team }

  subject { team }

  it { should be_valid }

end

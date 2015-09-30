require 'spec_helper'

describe Team do

  subject(:team) { create :team }
  let(:date) { Date.new(2015,7,1) }
  let(:player) { create :player }

  it { should be_valid }

end

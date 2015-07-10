require 'spec_helper'

describe Name do

  it "has a family name" do
    create :german_family_name
    expect(Name.family).to_not be_nil
  end

  it "has a pre name" do
    create :german_pre_name
    expect(Name.prename).to_not be_nil
  end
end

require 'spec_helper'

describe LogicalDate do
  before do
    create :logical_date
  end

  it "has a year" do
    expect(LogicalDate.year).to eq Date.today.year
  end

  it "has a date" do
    expect(LogicalDate.date).to eq Date.today.to_date
  end
end

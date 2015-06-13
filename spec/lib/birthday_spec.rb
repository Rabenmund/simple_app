require_relative "../../lib/birthday.rb"

describe Birthday do
  it "creates a young players date" do
    expect(Birthday.random).to be_in Date.today-20.years..Date.today-17.years
  end

  it "creates a normal distributed birthdate" do
    expect(Birthday.normal_distribution).to be_a Date
  end
end

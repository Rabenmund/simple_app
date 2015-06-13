describe Human do
  let(:human) { create :human, birthday: Date.today-199.days }

  it "has an age" do
    expect(human.age).to eq 199
  end
end

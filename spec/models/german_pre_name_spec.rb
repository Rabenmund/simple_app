describe GermanPreName do
  let(:name) { create :german_pre_name }

  it "is valid" do
    expect(name).to be_valid
  end
end

describe GermanFamilyName do
  let(:name) { create :german_family_name }

  it "is valid" do
    expect(name).to be_valid
  end
end


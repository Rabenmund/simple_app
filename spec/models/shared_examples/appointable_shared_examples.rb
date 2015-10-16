require "spec_helper"

shared_examples_for Appointable do
  let!(:appointment) {create :appointment, appointable: testable }

  it "and has a valid appointable" do
    expect(appointment).to be_valid
  end

  it "delegates appointed_at to appointment" do
    expect(testable.appointed_at).to eq appointment.appointed_at
  end
end

require "spec_helper"

shared_examples_for Appointable do
  let(:appointment) {testable.appointment}

  it "and has a valid appointable" do
    expect(appointment).to be_valid
  end

  context "#ensure_appointment" do
    let!(:new_testable) {build testable.class.name.downcase.to_s}

    it "creates an appointment after save" do
      expect{new_testable.save}.to change{Appointment.count}.by(1)
      expect(new_testable.appointment).to eq Appointment.last
    end

  end

end

require "spec_helper"

shared_examples_for Appointable do
  let(:appointment) {testable.appointment}

  it "and has a valid appointable" do
    expect(appointment).to be_valid
  end

  context "#ensure_appointment" do

    it "creates an appointment after save" do
      new_testable = build testable.class.name.downcase.to_s
      expect{new_testable.save}.to change{Appointment.count}.by(1)
      expect(new_testable.appointment).to eq Appointment.last
    end

    it "deletes an appointment when appointable is finish!" do
      allow(CalculatePoints).to receive(:new).and_return double(update!: :updated)
      allow(testable).to receive_messages(home_goals: 1, guest_goals: 1)
      testable.finish!
      expect(testable.reload.appointment).to be_nil
    end

  end

end

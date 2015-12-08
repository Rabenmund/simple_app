require 'spec_helper'

RSpec.describe Appointment do
  let(:appointment) { create :appointment }

  it "is valid" do
    expect(appointment).to be_valid
  end

  it "adds a minute" do
    old = appointment.appointed_at
    appointment.add_a_minute!
    expect(appointment.reload.appointed_at).to eq (old + 1.minute)
  end
end

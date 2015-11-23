require 'spec_helper'

RSpec.describe GameRepository::GameCreator do
  subject(:creator) { described_class }
  let(:game) { build :game }
  let(:attributes) { game.attributes }
  let(:date) { Date.new(2015,7,1) }

  it "creates a game including the appointment" do
    game = creator.with_appointment(date: date, attributes: attributes)
    expect(game).to be_a Game
    expect(game).to be_valid
    expect(game.appointment).to be_a Appointment
    expect(game.appointment.appointed_at).to eq date
    expect(Appointment.all.count).to eq 1
  end
end

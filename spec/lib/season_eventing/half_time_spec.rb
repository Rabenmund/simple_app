require 'spec_helper'

RSpec.describe SeasonEventing::HalfTime do
  let!(:event) { create :half_time }
  let!(:appointment) do
    create :appointment, appointed_at: sylvester, appointable: event
  end
  let(:sylvester) { Date.new(event.season.start_date.year, 12, 31) }

  it 'is valid' do
    expect(event).to be_valid
  end

  it 'has an appointment' do
    expect(event.appointed_at).to eq sylvester
  end

  it "performs the half-time events if called" do
    expect(SeasonUseCase::TeamProlongations)
      .to receive(:new)
      .with(date: event.season.end_date)
      .and_return(
        double("TeamProlongations", decisions: :ids_of_prolongated_players))
    expect(SeasonUseCase::PlayerRetirements)
      .to receive(:new)
      .with(year: event.season.end_date.year)
      .and_return(
        double("PlayerRetirements", decisions: :ids_of_retired_players))
    expect(PlayerUseCase::AllDecideOffers)
      .to receive(:decisions)
    expect(SeasonUseCase::ProduceMissingPlayers)
      .to receive(:at)
      .with(event.season.end_date+1.day)
    event.call
  end
end

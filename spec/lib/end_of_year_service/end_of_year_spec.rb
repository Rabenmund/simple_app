require_relative '../../../lib/end_of_year_service/end_of_year'

RSpec.describe EndOfYearService::EndOfYear do
  subject(:end_of_year) { EndOfYearService::EndOfYear.new(year: 2015) }

  it "asks for retirements" do
    allow(EndOfYearService::Prolongations)
      .to receive(:new)
      .and_return(
        double("Prolongations", ask_for_decisions: :ids_of_prolongated_players))
    expect(EndOfYearService::Retirements)
      .to receive(:new)
      .with(year: 2015)
      .and_return(
        double("Retirements", ask_for_decisions: :ids_of_retired_players))
    end_of_year.call
  end

  it "asks for contract prolongations" do
    allow(EndOfYearService::Retirements)
      .to receive(:new)
      .and_return(
        double("Retirements", ask_for_decisions: :ids_of_retired_players))
    expect(EndOfYearService::Prolongations)
      .to receive(:new)
      .with(year: 2015)
      .and_return(
        double("Prolongations", ask_for_decisions: :ids_of_prolongated_players))
    end_of_year.call
  end

  it "generates new players"

end

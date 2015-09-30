require_relative '../../../../lib/use_cases/end_of_year_use_case/end_of_year'

RSpec.describe EndOfYearUseCase::EndOfYear do
  subject(:end_of_year) { EndOfYearUseCase::EndOfYear.call(year: 2015) }

  it "asks for retirements" do
    allow(EndOfYearUseCase::TeamProlongations)
      .to receive(:new)
      .and_return(
        double("TeamProlongations", decisions: :ids_of_prolongated_players))
    expect(EndOfYearUseCase::PlayerRetirements)
      .to receive(:new)
      .with(year: 2015)
      .and_return(
        double("PlayerRetirements", decisions: :ids_of_retired_players))
    end_of_year
  end

  it "asks for contract prolongations" do
    allow(EndOfYearUseCase::PlayerRetirements)
      .to receive(:new)
      .and_return(
        double("PlayerRetirements", decisions: :ids_of_retired_players))
    expect(EndOfYearUseCase::TeamProlongations)
      .to receive(:new)
      .with(date: Date.new(2016,06,30))
      .and_return(
        double("TeamProlongations", decisions: :ids_of_prolongated_players))
    end_of_year
  end

  it "generates new players"

end
